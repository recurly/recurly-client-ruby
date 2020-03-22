require "logger"
require "erb"
require "net/https"
require "base64"
require_relative "./schema/json_parser"
require_relative "./schema/file_parser"

module Recurly
  class Client
    require_relative "./client/operations"

    BASE_HOST = "v3.recurly.com"
    BASE_PORT = 443
    CA_FILE = File.join(File.dirname(__FILE__), "../data/ca-certificates.crt")
    BINARY_TYPES = [
      "application/pdf",
    ]
    JSON_CONTENT_TYPE = "application/json"
    MAX_RETRIES = 3

    # Initialize a client. It requires an API key.
    #
    # @example
    #   API_KEY = '83749879bbde395b5fe0cc1a5abf8e5'
    #   client = Recurly::Client.new(api_key: API_KEY)
    #   sub = client.get_subscription(subscription_id: 'abcd123456')
    # @example
    #   # You can also pass the initializer a block. This will give you
    #   # a client scoped for just that block
    #   Recurly::Client.new(api_key: API_KEY) do |client|
    #     sub = client.get_subscription(subscription_id: 'abcd123456')
    #   end
    # @example
    #   # If you only plan on using the client for more than one site,
    #   # you should initialize a new client for each site.
    #
    #   client = Recurly::Client.new(api_key: API_KEY1)
    #   sub = client.get_subscription(subscription_id: 'uuid-abcd123456')
    #
    #   # you should create a new client to connect to another site
    #   client = Recurly::Client.new(api_key: API_KEY2)
    #   sub = client.get_subscription(subscription_id: 'uuid-abcd7890')
    #
    # @param api_key [String] The private API key
    # @param site_id [String] The site you wish to be scoped to.
    # @param subdomain [String] Optional subdomain for the site you wish to be scoped to. Providing this makes all the `site_id` parameters optional.
    def initialize(api_key:, site_id: nil, subdomain: nil, **options)
      set_site_id(site_id, subdomain)
      set_api_key(api_key)
      set_options(options)

      # execute block with this client if given
      yield(self) if block_given?
    end

    def next_page(pager)
      path = extract_path(pager.next)
      request = Net::HTTP::Get.new path
      http_response = run_request(request)
      handle_response! request, http_response
    end

    protected

    def pager(path, **options)
      path = scope_by_site(path, **options)
      Pager.new(
        client: self,
        path: path,
        options: options,
      )
    end

    def get(path, **options)
      path = scope_by_site(path, **options)
      request = Net::HTTP::Get.new path
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def post(path, request_data, request_class, **options)
      request_class.new(request_data).validate!
      path = scope_by_site(path, **options)
      request = Net::HTTP::Post.new path
      request.set_content_type(JSON_CONTENT_TYPE)
      request.body = JSON.dump(request_data)
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def put(path, request_data = nil, request_class = nil, **options)
      path = scope_by_site(path, **options)
      request = Net::HTTP::Put.new path
      request.set_content_type(JSON_CONTENT_TYPE)
      if request_data
        request_class.new(request_data).validate!
        json_body = JSON.dump(request_data)
        logger.info("PUT BODY #{json_body}")
        request.body = json_body
      end
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def delete(path, **options)
      path = scope_by_site(path, **options)
      request = Net::HTTP::Delete.new path
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    protected

    # Used by the operations.rb file to interpolate paths
    attr_reader :site_id

    private

    # @return [Logger]
    attr_reader :logger

    def connection_pool
      @@connection_pool ||= Recurly::ConnectionPool.new
    end

    def run_request(request, options = {})
      request["Accept"] = "application/vnd.recurly.#{api_version}".chomp # got this method from operations.rb
      request["Authorization"] = "Basic #{Base64.encode64(@api_key)}".chomp
      request["User-Agent"] = "Recurly/#{VERSION}; #{RUBY_DESCRIPTION}"

      # TODO this is undocumented until we finalize it
      options[:headers].each { |header, v| request[header] = v } if options[:headers]

      connection_pool.with_connection do |http|
        http.open_timeout = options[:open_timeout] || 20
        http.read_timeout = options[:read_timeout] || 60

        retries = 0

        begin
          unless http.started?
            http.set_debug_output(logger) if @log_level <= Logger::INFO
            http.start
          end

          http.request(request)
        rescue EOFError, Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::EHOSTUNREACH, Errno::ECONNABORTED, Errno::EPIPE, Errno::ETIMEDOUT, Net::OpenTimeout => ex
          retries += 1
          if retries < MAX_RETRIES
            retry
          end

          http.finish if http.started? # do not add back to pool

          if ex.kind_of?(Net::OpenTimeout) || ex.kind_of?(Errno::ETIMEDOUT)
            raise Recurly::Errors::TimeoutError, "Request timed out"
          end

          raise Recurly::Errors::ConnectionFailedError, "Failed to connect to Recurly: #{ex.message}"
        rescue Net::ReadTimeout, Timeout::Error
          http.finish if http.started? # do not add back to pool
          raise Recurly::Errors::TimeoutError, "Request timed out"
        rescue OpenSSL::SSL::SSLError => ex
          raise Recurly::Errors::SSLError, ex.message
        end
      end
    end

    def handle_response!(request, http_response)
      response = HTTP::Response.new(http_response, request)
      raise_api_error!(response) unless http_response.kind_of?(Net::HTTPSuccess)
      resource = if response.body
          if http_response.content_type.include?(JSON_CONTENT_TYPE)
            JSONParser.parse(self, response.body)
          elsif BINARY_TYPES.include?(http_response.content_type)
            FileParser.parse(response.body)
          else
            raise Recurly::Errors::InvalidResponseError, "Unexpected content type: #{http_response.content_type}"
          end
        else
          Resources::Empty.new
        end
      # Keep this interface "private"
      resource.instance_variable_set(:@response, response)
      resource
    end

    def raise_api_error!(response)
      if response.content_type.include?(JSON_CONTENT_TYPE)
        error = JSONParser.parse(self, response.body)
        error_class = Errors::APIError.error_class(error.type)
        raise error_class.new(response, error)
      else
        raise Recurly::Errors::InvalidResponseError, "Unexpected content type: #{http_response.content_type}"
      end
    end

    def read_headers(response)
      if !@_ignore_deprecation_warning && response.headers["Recurly-Deprecated"]&.upcase == "TRUE"
        puts "[recurly-client-ruby] WARNING: Your current API version \"#{api_version}\" is deprecated and will be sunset on #{response.headers["Recurly-Sunset-Date"]}"
      end
      response
    end

    def interpolate_path(path, **options)
      options.each do |k, v|
        # Check to see that we are passing the correct data types
        # This prevents a confusing error if the user passes in a non-primitive by mistake
        unless [String, Symbol, Integer, Float].include?(v.class)
          message = "We cannot build the url with the given argument #{k}=#{v.inspect}."
          if k =~ /_id$/
            message << " Since this appears to be an id, perhaps you meant to pass in a String?"
          end
          raise ArgumentError, message
        end
        # We need to encode the values for the url
        options[k] = ERB::Util.url_encode(v.to_s)
      end
      path = path.gsub("{", "%{")
      path % options
    end

    def set_site_id(site_id, subdomain)
      if site_id
        @site_id = site_id
      elsif subdomain
        @site_id = "subdomain-#{subdomain}"
      end
    end

    def set_api_key(api_key)
      @api_key = api_key
    end

    def scope_by_site(path, **options)
      if site = site_id || options[:site_id]
        "/sites/#{site}#{path}"
      else
        path
      end
    end

    # Returns just the path and parameters so we can safely reuse the connection
    def extract_path(uri_or_path)
      uri = URI(uri_or_path)
      uri.kind_of?(URI::HTTP) ? uri.request_uri : uri_or_path
    end

    def set_options(options)
      @log_level = options[:log_level] || Logger::WARN
      @logger = Logger.new(STDOUT)
      @logger.level = @log_level
    end
  end
end

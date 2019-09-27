require "faraday"
require "logger"
require "erb"
require_relative "./schema/json_parser"
require_relative "./client/adapter"

module Recurly
  class Client
    require_relative "./client/operations"

    BASE_URL = "https://v3.recurly.com/"

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
      set_options(options)
      set_faraday_connection(api_key)

      # execute block with this client if given
      yield(self) if block_given?
    end

    def next_page(pager)
      req = HTTP::Request.new(:get, pager.next, nil)
      faraday_resp = run_request(req, headers)
      handle_response! req, faraday_resp
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
      request = HTTP::Request.new(:get, path, nil)
      faraday_resp = run_request(request, headers)
      handle_response! request, faraday_resp
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def post(path, request_data, request_class, **options)
      request_class.new(request_data).validate!
      path = scope_by_site(path, **options)
      request = HTTP::Request.new(:post, path, JSON.dump(request_data))
      faraday_resp = run_request(request, headers)
      handle_response! request, faraday_resp
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def put(path, request_data = nil, request_class = nil, **options)
      path = scope_by_site(path, **options)
      request = HTTP::Request.new(:put, path)
      if request_data
        request_class.new(request_data).validate!
        logger.info("PUT BODY #{JSON.dump(request_data)}")
        request.body = JSON.dump(request_data)
      end
      faraday_resp = run_request(request, headers)
      handle_response! request, faraday_resp
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def delete(path, **options)
      path = scope_by_site(path, **options)
      request = HTTP::Request.new(:delete, path, nil)
      faraday_resp = run_request(request, headers)
      handle_response! request, faraday_resp
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    protected

    # Used by the operations.rb file to interpolate paths
    attr_reader :site_id

    private

    # @return [Logger]
    attr_reader :logger

    def run_request(request, headers)
      read_headers @conn.run_request(request.method, request.path, request.body, headers)
    end

    def handle_response!(request, faraday_resp)
      response = HTTP::Response.new(faraday_resp, request)
      raise_api_error!(response) unless (200...300).include?(response.status)
      resource = if response.body
                   JSONParser.parse(self, response.body)
                 else
                   Resources::Empty.new
                 end
      # Keep this interface "private"
      resource.instance_variable_set(:@response, response)
      resource
    end

    def raise_network_error!(ex)
      error_class = case ex
                    when Faraday::TimeoutError
                      Errors::TimeoutError
                    when Faraday::ConnectionFailed
                      Errors::ConnectionFailedError
                    when Faraday::SSLError
                      Errors::SSLError
                    else
                      Errors::NetworkError
                    end

      raise error_class, ex.message
    end

    def raise_api_error!(response)
      error = JSONParser.parse(self, response.body)
      error_class = Errors::APIError.error_class(error.type)
      raise error_class.new(response, error)
    end

    def read_headers(response)
      if !@_ignore_deprecation_warning && response.headers["Recurly-Deprecated"]&.upcase == "TRUE"
        puts "[recurly-client-ruby] WARNING: Your current API version \"#{api_version}\" is deprecated and will be sunset on #{response.headers["Recurly-Sunset-Date"]}"
      end
      response
    end

    def headers
      {
        "Accept" => "application/vnd.recurly.#{api_version}", # got this method from operations.rb
        "Content-Type" => "application/json",
        "User-Agent" => "Recurly/#{VERSION}; #{RUBY_DESCRIPTION}",
      }.merge(@extra_headers)
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

    def scope_by_site(path, **options)
      if site = site_id || options[:site_id]
        "/sites/#{site}#{path}"
      else
        path
      end
    end

    def set_faraday_connection(api_key)
      options = {
        url: BASE_URL,
        request: { timeout: 60, open_timeout: 50 },
        ssl: { verify: true },
      }
      # Let's not use the bundled cert in production yet
      # but we will use these certs for any other staging or dev environment
      unless BASE_URL.end_with?(".recurly.com")
        options[:ssl][:ca_file] = File.join(File.dirname(__FILE__), "../data/ca-certificates.crt")
      end

      @conn = Faraday.new(options) do |faraday|
        if [Logger::DEBUG, Logger::INFO].include?(@log_level)
          faraday.response :logger
        end
        faraday.basic_auth(api_key, "")
        configure_net_adapter(faraday)
      end
    end

    def set_options(options)
      @log_level = options[:log_level] || Logger::WARN
      @logger = Logger.new(STDOUT)
      @logger.level = @log_level

      # TODO this is undocumented until we finalize it
      @extra_headers = options[:headers] || {}
    end
  end
end

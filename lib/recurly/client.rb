require "faraday"
require "logger"
require "erb"
require_relative "./schema/json_parser"
require_relative "./client/adapter"

module Recurly
  class Client
    require_relative "./client/operations"

    BASE_URL = "https://partner-api.recurly.com/"

    # The last result of the *X-RateLimit-Limit* header
    # @return [Integer] The rate limit applied to this client.
    attr_reader :rate_limit

    # The last result of the *X-RateLimit-Remaining* header
    # @return [Integer] The number of remaining requests, decrements per request.
    attr_reader :rate_limit_remaining

    # The last result of the *X-RateLimit-Reset* header
    # @return [DateTime] The DateTime in which the request count will be reset.
    attr_reader :rate_limit_reset

    # Initialize a client. It requires an API key.
    #
    # @example
    #   API_KEY = '83749879bbde395b5fe0cc1a5abf8e5'
    #   SITE_ID = 'dqzlv9shi7wa'
    #   client = Recurly::Client.new(site_id: SITE_ID, api_key: API_KEY)
    #   # You can optionally use the subdomain instead of the site id
    #   client = Recurly::Client.new(subdomain: 'mysite-prod', api_key: API_KEY)
    #   sub = client.get_subscription(subscription_id: 'abcd123456')
    # @example
    #   # You can also pass the initializer a block. This will give you
    #   # a client scoped for just that block
    #   Recurly::Client.new(subdomain: 'mysite-prod', api_key: API_KEY) do |client|
    #     sub = client.get_subscription(subscription_id: 'abcd123456')
    #   end
    # @example
    #   # If you only plan on using the client for more than one site,
    #   # you should initialize a new client for each site.
    #
    #   # Give a `site_id`
    #   client = Recurly::Client.new(api_key: API_KEY, site_id: SITE_ID)
    #   # Or use the subdomain
    #   client = Recurly::Client.new(api_key: API_KEY, subdomain: 'mysite-dev')
    #
    #   sub = client.get_subscription(subscription_id: 'abcd123456')
    #
    #   # you should create a new client to connect to another site
    #   client = Recurly::Client.new(api_key: API_KEY, subdomain: 'mysite-prod')
    #   sub = client.get_subscription(subscription_id: 'abcd7890')
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
      run_request(:get, pager.next, nil, headers).tap do |response|
        raise_api_error!(response) unless (200...300).include?(response.status)
      end
    end

    protected

    def pager(path, **options)
      Pager.new(client: self, path: path, options: options)
    end

    def get(path, **options)
      response = run_request(:get, path, nil, headers)
      raise_api_error!(response) unless (200...300).include?(response.status)
      JSONParser.parse(self, response.body)
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def post(path, request_data, request_class, **options)
      request = request_class.new(request_data)
      request.validate!
      logger.info("POST BODY #{JSON.dump(request_data)}")
      response = run_request(:post, path, JSON.dump(request.attributes), headers)
      raise_api_error!(response) unless (200...300).include?(response.status)
      JSONParser.parse(self, response.body)
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def put(path, request_data = nil, request_class = nil, **options)
      response = if request_data
                   request = request_class.new(request_data)
                   request.validate!
                   logger.info("PUT BODY #{JSON.dump(request_data)}")
                   run_request(:put, path, JSON.dump(request_data), headers)
                 else
                   run_request(:put, path, nil, headers)
                 end
      raise_api_error!(response) unless (200...300).include?(response.status)
      JSONParser.parse(self, response.body)
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    def delete(path, **options)
      response = run_request(:delete, path, nil, headers)
      raise_api_error!(response) unless (200...300).include?(response.status)
      if response.body && !response.body.empty?
        JSONParser.parse(self, response.body)
      end
    rescue Faraday::ClientError => ex
      raise_network_error!(ex)
    end

    protected

    # Used by the operations.rb file to interpolate paths
    attr_reader :site_id

    private

    # @return [Logger]
    attr_reader :logger

    def run_request(method, url, body, headers)
      read_headers @conn.run_request(method, url, body, headers)
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
      @rate_limit = response.headers["x-ratelimit-limit"].to_i
      @rate_limit_remaining = response.headers["x-ratelimit-remaining"].to_i
      @rate_limit_reset = Time.at(response.headers["x-ratelimit-reset"].to_i).to_datetime
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
      else
        raise ArgumentError, "You must pass a site_id or subdomain argument to initialize the Client"
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

require "logger"
require "erb"
require "net/https"
require "base64"
require "securerandom"
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
    ].freeze
    JSON_CONTENT_TYPE = "application/json"
    MAX_RETRIES = 3
    LOG_LEVELS = %i(debug info warn error fatal).freeze
    BASE36_ALPHABET = (("0".."9").to_a + ("a".."z").to_a).freeze
    ALLOWED_OPTIONS = [
      :site_id,
      :open_timeout,
      :read_timeout,
      :body,
      :params,
      :headers,
    ].freeze

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
    # @param logger [Logger] A logger to use. Defaults to creating a new STDOUT logger with level WARN.
    def initialize(api_key:, site_id: nil, subdomain: nil, logger: nil)
      set_site_id(site_id, subdomain)
      set_api_key(api_key)

      if logger.nil?
        @logger = Logger.new(STDOUT).tap do |l|
          l.level = Logger::WARN
        end
      else
        unless LOG_LEVELS.all? { |lev| logger.respond_to?(lev) }
          raise ArgumentError, "You must pass in a logger implementation that responds to the following messages: #{LOG_LEVELS}"
        end
        @logger = logger
      end

      if @logger.level < Logger::INFO
        msg = <<-MSG
        The Recurly logger should not be initialized
        beyond the level INFO. It is currently configured to emit
        headers and request / response bodies. This has the potential to leak
        PII and other sensitive information and should never be used in production.
        MSG
        log_warn("SECURITY_WARNING", message: msg)
      end

      # execute block with this client if given
      yield(self) if block_given?
    end

    protected

    # Used by the operations.rb file to interpolate paths
    attr_reader :site_id

    def pager(path, **options)
      Pager.new(
        client: self,
        path: path,
        options: options,
      )
    end

    def head(path, **options)
      validate_options!(options)
      request = Net::HTTP::Head.new build_url(path, options)
      set_headers(request, options[:headers])
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def get(path, **options)
      validate_options!(options)
      request = Net::HTTP::Get.new build_url(path, options)
      set_headers(request, options[:headers])
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def post(path, request_data, request_class, **options)
      validate_options!(options)
      request_class.new(request_data).validate!
      request = Net::HTTP::Post.new build_url(path, options)
      request.set_content_type(JSON_CONTENT_TYPE)
      set_headers(request, options[:headers])
      request.body = JSON.dump(request_data)
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def put(path, request_data = nil, request_class = nil, **options)
      validate_options!(options)
      request = Net::HTTP::Put.new build_url(path, options)
      request.set_content_type(JSON_CONTENT_TYPE)
      set_headers(request, options[:headers])
      if request_data
        request_class.new(request_data).validate!
        json_body = JSON.dump(request_data)
        request.body = json_body
      end
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    def delete(path, **options)
      validate_options!(options)
      request = Net::HTTP::Delete.new build_url(path, options)
      set_headers(request, options[:headers])
      http_response = run_request(request, options)
      handle_response! request, http_response
    end

    private

    @connection_pool = Recurly::ConnectionPool.new

    class << self
      # @return [Recurly::ConnectionPool]
      attr_accessor :connection_pool
    end

    def run_request(request, options = {})
      self.class.connection_pool.with_connection do |http|
        set_http_options(http, options)

        retries = 0

        begin
          http.start unless http.started?
          log_attrs = {
            method: request.method,
            path: request.path,
          }
          if @logger.level < Logger::INFO
            log_attrs[:request_body] = request.body
            # No need to log the authorization header
            headers = request.to_hash.reject { |k, _| k&.downcase == "authorization" }
            log_attrs[:request_headers] = headers
          end

          log_info("Request", **log_attrs)
          start = Time.now
          response = http.request(request)
          elapsed = Time.now - start

          # GETs are safe to retry after a server error, requests with an Idempotency-Key will return the prior response
          if response.kind_of?(Net::HTTPServerError) && request.is_a?(Net::HTTP::Get)
            retries += 1
            log_info("Retrying", retries: retries, **log_attrs)
            start = Time.now
            response = http.request(request) if retries < MAX_RETRIES
            elapsed = Time.now - start
          end

          if @logger.level < Logger::INFO
            log_attrs[:response_body] = response.body
            log_attrs[:response_headers] = response.to_hash
          end
          log_info("Response", time_ms: (elapsed * 1_000).floor, status: response.code, **log_attrs)

          response
        rescue Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::EHOSTUNREACH, Errno::ECONNABORTED,
               Errno::EPIPE, Errno::ETIMEDOUT, Net::OpenTimeout, EOFError, SocketError => ex
          retries += 1
          if retries < MAX_RETRIES
            retry
          end

          if ex.kind_of?(Net::OpenTimeout) || ex.kind_of?(Errno::ETIMEDOUT)
            raise Recurly::Errors::TimeoutError, "Request timed out"
          end

          raise Recurly::Errors::ConnectionFailedError, "Failed to connect to Recurly: #{ex.message}"
        rescue Net::ReadTimeout, Timeout::Error
          raise Recurly::Errors::TimeoutError, "Request timed out"
        rescue OpenSSL::SSL::SSLError => ex
          raise Recurly::Errors::SSLError, ex.message
        rescue StandardError => ex
          raise Recurly::Errors::NetworkError, ex.message
        end
      end
    end

    def set_headers(request, additional_headers = {})
      # TODO this is undocumented until we finalize it
      additional_headers.each { |header, v| request[header] = v } if additional_headers

      request["Accept"] = "application/vnd.recurly.#{api_version}".chomp # got this method from operations.rb
      request["Authorization"] = "Basic #{Base64.encode64(@api_key)}".chomp
      request["User-Agent"] = "Recurly/#{VERSION}; #{RUBY_DESCRIPTION}"

      unless request.is_a?(Net::HTTP::Get) || request.is_a?(Net::HTTP::Head)
        request["Idempotency-Key"] ||= generate_idempotency_key
      end
    end

    # from https://github.com/rails/rails/blob/6-0-stable/activesupport/lib/active_support/core_ext/securerandom.rb
    def generate_idempotency_key(n = 16)
      SecureRandom.random_bytes(n).unpack("C*").map do |byte|
        idx = byte % 64
        idx = SecureRandom.random_number(36) if idx >= 36
        BASE36_ALPHABET[idx]
      end.join
    end

    def set_http_options(http, options)
      http.open_timeout = options[:open_timeout] || 20
      http.read_timeout = options[:read_timeout] || 60
    end

    def handle_response!(request, http_response)
      response = HTTP::Response.new(http_response, request)
      raise_api_error!(http_response, response) unless http_response.kind_of?(Net::HTTPSuccess)
      resource = if response.body
          if http_response.content_type&.include?(JSON_CONTENT_TYPE)
            JSONParser.parse(self, response.body)
          elsif BINARY_TYPES.include?(http_response.content_type)
            FileParser.parse(response.body)
          else
            raise Recurly::Errors::InvalidContentTypeError, "Unexpected content type: #{http_response.content_type}"
          end
        else
          Resources::Empty.new
        end
      # Keep this interface "private"
      resource.instance_variable_set(:@response, response)
      resource
    end

    def raise_api_error!(http_response, response)
      if response.content_type.include?(JSON_CONTENT_TYPE)
        error = JSONParser.parse(self, response.body)
        error_class = Errors::APIError.error_class(error.type)
        raise error_class.new(error.message, response, error)
      end

      error_class = Errors::APIError.from_response(http_response)

      if error_class <= Recurly::Errors::APIError
        error = Recurly::Resources::Error.new(message: "#{http_response.code}: #{http_response.message}")
        raise error_class.new(error.message, response, error)
      else
        raise error_class, "#{http_response.code}: #{http_response.message}"
      end
    end

    def read_headers(response)
      if !@_ignore_deprecation_warning && response.headers["Recurly-Deprecated"]&.upcase == "TRUE"
        log_warn("DEPRECTATION WARNING", message: "Your current API version \"#{api_version}\" is deprecated and will be sunset on #{response.headers["Recurly-Sunset-Date"]}")
      end
      response
    end

    def validate_options!(**options)
      invalid_options = options.keys.reject do |k|
        ALLOWED_OPTIONS.include?(k)
      end
      if invalid_options.any?
        joinedKeys = invalid_options.join(", ")
        joinedOptions = ALLOWED_OPTIONS.join(", ")
        raise ArgumentError, "Invalid options: '#{joinedKeys}'. Allowed options: '#{joinedOptions}'"
      end
    end

    def validate_path_parameters!(**options)
      # Check to see that we are passing the correct data types
      # This prevents a confusing error if the user passes in a non-primitive by mistake
      options.each do |k, v|
        unless [String, Symbol, Integer, Float].include?(v.class)
          message = "We cannot build the url with the given argument #{k}=#{v.inspect}."
          if k =~ /_id$/
            message << " Since this appears to be an id, perhaps you meant to pass in a String?"
          end
          raise ArgumentError, message
        end
      end
      # Check to make sure that parameters are not empty string values
      empty_strings = options.select { |_, v| v.is_a?(String) && v.strip.empty? }
      if empty_strings.any?
        raise ArgumentError, "#{empty_strings.keys.join(", ")} cannot be an empty string"
      end
    end

    def interpolate_path(path, **options)
      validate_path_parameters!(options)
      options.each do |k, v|
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

    def build_url(path, options)
      path = scope_by_site(path, options)
      query_params = map_array_params(options.fetch(:params, {}))
      if query_params.any?
        "#{path}?#{URI.encode_www_form(query_params)}"
      else
        path
      end
    end

    # Converts array parameters to CSV strings to maintain consistency with
    # how the server expects the request to be formatted while providing the
    # developer with an array type to maintain developer happiness!
    def map_array_params(params)
      params.map do |key, param|
        [key, param.is_a?(Array) ? param.join(",") : param]
      end.to_h
    end

    def scope_by_site(path, **options)
      if site = site_id || options[:site_id]
        # Ensure that we are only including the site_id once because the Pager operations
        # will use the cursor returned from the API which may already have these components
        path.start_with?("/sites/#{site}") ? path : "/sites/#{site}#{path}"
      else
        path
      end
    end

    # Define a private `log_<level>` method for each log level
    LOG_LEVELS.each do |level|
      define_method "log_#{level}" do |tag, **attrs|
        @logger.send(level, "Recurly") do
          msg = attrs.each_pair.map { |k, v| "#{k}=#{v.inspect}" }.join(" ")
          "[#{tag}] #{msg}"
        end
      end
    end
  end
end

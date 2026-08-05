require "logger"
require "erb"
require "net/https"
require "base64"
require "securerandom"
require "uri"
require_relative "./schema/json_parser"
require_relative "./schema/file_parser"

module Recurly
  class Client
    require_relative "./client/operations"

    API_HOSTS = {
      us: "https://v3.recurly.com",
      eu: "https://v3.eu.recurly.com",
    }
    REGION = :us
    CA_FILE = File.join(File.dirname(__FILE__), "../data/ca-certificates.crt")
    BINARY_TYPES = [
      "application/pdf",
    ].freeze
    JSON_CONTENT_TYPE = "application/json"
    MAX_RETRIES = 3
    LOG_LEVELS = %i(debug info warn error fatal).freeze
    BASE36_ALPHABET = (("0".."9").to_a + ("a".."z").to_a).freeze

    # Vendored HTTP status → reason-phrase table. Used to synthesize a
    # reason_phrase when a (custom) adapter did not surface one. On the default
    # path the adapter provides Net::HTTP's reason phrase, so this is not
    # consulted and behavior is byte-identical. Phrases are bare (no status code
    # prefix) since callers build "#{code}: #{phrase}".
    HTTP_STATUS_MESSAGES = {
      200 => "OK", 201 => "Created", 202 => "Accepted", 204 => "No Content",
      301 => "Moved Permanently", 302 => "Found", 304 => "Not Modified",
      400 => "Bad Request", 401 => "Unauthorized", 402 => "Payment Required",
      403 => "Forbidden", 404 => "Not Found", 406 => "Not Acceptable",
      409 => "Conflict", 412 => "Precondition Failed", 422 => "Unprocessable Entity",
      429 => "Too Many Requests", 500 => "Internal Server Error", 502 => "Bad Gateway",
      503 => "Service Unavailable", 504 => "Gateway Timeout",
    }.freeze

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
    # @param region [String] The DataCenter that is called by the API. Default to "us"
    # @param base_url [String] The base URL for the API. Defaults to "https://v3.recurly.com"
    # @param ca_file [String] The CA bundle to use when connecting to the API. Defaults to "data/ca-certificates.crt"
    # @param api_key [String] The private API key
    # @param logger [Logger] A logger to use. Defaults to creating a new STDOUT logger with level WARN.
    def initialize(region: REGION, base_url: API_HOSTS[:us], ca_file: CA_FILE, api_key:, logger: nil, keep_alive_timeout: 600, http_adapter: nil)
      raise ArgumentError, "'api_key' must be set to a non-nil value" if api_key.nil?

      raise ArgumentError, "Invalid region type. Expected one of: #{API_HOSTS.keys.join(", ")}" if !API_HOSTS.key?(region)

      base_url = API_HOSTS[region] if base_url == API_HOSTS[:us] && API_HOSTS.key?(region)

      set_api_key(api_key)
      set_connection_options(base_url, ca_file, keep_alive_timeout)

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

      @http_adapter = http_adapter || HTTP::DefaultHttpAdapter.new(
        connection_pool: self.class.connection_pool,
        keep_alive_timeout: @keep_alive_timeout,
        ca_file: @ca_file,
      )

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
      validate_options!(**options)
      relative_path = build_url(path, options)
      headers = build_headers(HTTP::HttpMethod::HEAD, options[:headers])
      request = HTTP::Request.new(HTTP::HttpMethod::HEAD, relative_path, nil)
      response = run_request(request, headers, options)
      handle_response! request, response
    end

    def get(path, **options)
      validate_options!(**options)
      relative_path = build_url(path, options)
      headers = build_headers(HTTP::HttpMethod::GET, options[:headers])
      request = HTTP::Request.new(HTTP::HttpMethod::GET, relative_path, nil)
      response = run_request(request, headers, options)
      handle_response! request, response
    end

    def post(path, request_data = nil, request_class = nil, **options)
      validate_options!(**options)
      relative_path = build_url(path, options)
      headers = build_headers(HTTP::HttpMethod::POST, options[:headers])
      body = nil
      if request_data
        request_class.new(request_data).validate!
        body = JSON.dump(request_data)
      end
      request = HTTP::Request.new(HTTP::HttpMethod::POST, relative_path, body)
      response = run_request(request, headers, options)
      handle_response! request, response
    end

    def put(path, request_data = nil, request_class = nil, **options)
      validate_options!(**options)
      relative_path = build_url(path, options)
      headers = build_headers(HTTP::HttpMethod::PUT, options[:headers])
      body = nil
      if request_data
        request_class.new(request_data).validate!
        body = JSON.dump(request_data)
      end
      request = HTTP::Request.new(HTTP::HttpMethod::PUT, relative_path, body)
      response = run_request(request, headers, options)
      handle_response! request, response
    end

    def delete(path, **options)
      validate_options!(**options)
      relative_path = build_url(path, options)
      headers = build_headers(HTTP::HttpMethod::DELETE, options[:headers])
      request = HTTP::Request.new(HTTP::HttpMethod::DELETE, relative_path, nil)
      response = run_request(request, headers, options)
      handle_response! request, response
    end

    private

    @connection_pool = Recurly::ConnectionPool.new

    class << self
      # @return [Recurly::ConnectionPool]
      attr_accessor :connection_pool
    end

    def run_request(request, headers, options = {})
      method = request.method
      body = request.body
      url = request_url(request.path)
      open_timeout = options[:open_timeout]
      read_timeout = options[:read_timeout]

      retries = 0

      log_attrs = {
        method: method,
        path: request.path,
      }
      if @logger.level < Logger::INFO
        log_attrs[:request_body] = body
        # No need to log the authorization header
        loggable_headers = headers.reject { |k, _| k&.downcase == "authorization" }
        log_attrs[:request_headers] = loggable_headers
      end

      begin
        log_info("Request", **log_attrs)
        start = Time.now
        response = @http_adapter.call(method, url, headers, body, open_timeout: open_timeout, read_timeout: read_timeout)
        elapsed = Time.now - start

        # GETs are safe to retry after a server error, requests with an Idempotency-Key will return the prior response.
        # This is a SINGLE inline re-issue (not a loop) that shares the same `retries` counter as the transport rescue.
        if response.status_code >= 500 && method == HTTP::HttpMethod::GET
          retries += 1
          if retries < MAX_RETRIES
            log_info("Retrying", retries: retries, **log_attrs)
            start = Time.now
            response = @http_adapter.call(method, url, headers, body, open_timeout: open_timeout, read_timeout: read_timeout)
            elapsed = Time.now - start
          end
        end

        if @logger.level < Logger::INFO
          log_attrs[:response_body] = response.body
          log_attrs[:response_headers] = response.headers
        end
        log_info("Response", time_ms: (elapsed * 1_000).floor, status: response.status_code, **log_attrs)

        response
      rescue Recurly::Errors::TransportError => ex
        retries += 1
        if retries < MAX_RETRIES
          retry
        end

        case ex.kind
        when :timeout
          raise Recurly::Errors::TimeoutError, "Request timed out"
        when :ssl
          raise Recurly::Errors::SSLError, ex.message
        when :connection
          raise Recurly::Errors::ConnectionFailedError, ex.message
        else
          raise Recurly::Errors::NetworkError, ex.message
        end
      end
    end

    # Builds the app-level request headers as a plain Hash. Header names are
    # compared case-insensitively so a caller-supplied header (any case)
    # overrides the SDK default instead of producing a duplicate.
    def build_headers(method, additional_headers = {})
      headers = {}

      # Content-Type must be applied FIRST for bodied verbs, so caller headers
      # can override it (parity with the old set_content_type-then-set_headers order).
      if method == HTTP::HttpMethod::POST || method == HTTP::HttpMethod::PUT
        headers["Content-Type"] = JSON_CONTENT_TYPE
      end

      # TODO this is undocumented until we finalize it
      if additional_headers
        additional_headers.each { |header, v| set_header(headers, header, v) }
      end

      set_header(headers, "Accept", "application/vnd.recurly.#{api_version}".chomp) # got this method from operations.rb
      set_header(headers, "Authorization", "Basic #{Base64.encode64(@api_key)}".chomp)
      set_header(headers, "User-Agent", "Recurly/#{VERSION}; #{RUBY_DESCRIPTION}")

      unless method == HTTP::HttpMethod::GET || method == HTTP::HttpMethod::HEAD
        # Only generate an Idempotency-Key if the caller did not supply one (any case).
        set_header(headers, "Idempotency-Key", generate_idempotency_key) unless header_key?(headers, "Idempotency-Key")
      end

      headers
    end

    # Sets a header, replacing any existing entry whose name matches
    # case-insensitively (so we never emit two headers differing only in case).
    def set_header(headers, name, value)
      existing = headers.keys.find { |k| k.to_s.downcase == name.to_s.downcase }
      headers.delete(existing) if existing
      headers[name] = value
    end

    # @return [Boolean] whether a header (case-insensitive) is already present
    def header_key?(headers, name)
      headers.keys.any? { |k| k.to_s.downcase == name.to_s.downcase }
    end

    # from https://github.com/rails/rails/blob/6-0-stable/activesupport/lib/active_support/core_ext/securerandom.rb
    def generate_idempotency_key(n = 16)
      SecureRandom.random_bytes(n).unpack("C*").map do |byte|
        idx = byte % 64
        idx = SecureRandom.random_number(36) if idx >= 36
        BASE36_ALPHABET[idx]
      end.join
    end

    def handle_response!(request, adapter_response)
      response = HTTP::Response.new(adapter_response, request)
      raise_api_error!(adapter_response, response) unless adapter_response.status_code.between?(200, 299)
      resource = if response.body
          if response.content_type&.include?(JSON_CONTENT_TYPE)
            JSONParser.parse(self, response.body)
          elsif BINARY_TYPES.include?(response.content_type)
            FileParser.parse(response.body)
          else
            raise Recurly::Errors::InvalidContentTypeError, "Unexpected content type: #{response.content_type}"
          end
        else
          Resources::Empty.new
        end
      # Keep this interface "private"
      resource.instance_variable_set(:@response, response)
      resource
    end

    def raise_api_error!(adapter_response, response)
      if response.content_type&.include?(JSON_CONTENT_TYPE) && response.body
        error = JSONParser.parse(self, response.body)
        begin
          error_class = Errors::APIError.error_class(error.type)
          raise error_class.new(error.message, response, error)
        rescue NameError
          error_class = Errors::APIError.from_response(adapter_response)
          raise error_class.new("Unknown Error", response, error)
        end
      end

      error_class = Errors::APIError.from_response(adapter_response)
      status_line = status_line_for(adapter_response)

      if error_class <= Recurly::Errors::APIError
        error = Recurly::Resources::Error.new(message: status_line)
        raise error_class.new(error.message, response, error)
      else
        raise error_class, status_line
      end
    end

    # Builds a "<code>: <phrase>" status line, falling back to the vendored
    # reason-phrase table and omitting the trailing ": " entirely when no
    # phrase can be found (e.g. a custom adapter on an uncommon status code).
    def status_line_for(adapter_response)
      phrase = adapter_response.reason_phrase || HTTP_STATUS_MESSAGES[adapter_response.status_code]
      phrase ? "#{adapter_response.status_code}: #{phrase}" : adapter_response.status_code.to_s
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
      validate_path_parameters!(**options)
      options.each do |k, v|
        # We need to encode the values for the url
        options[k] = ERB::Util.url_encode(v.to_s)
      end
      path = path.gsub("{", "%{")
      path % options
    end

    def set_api_key(api_key)
      @api_key = api_key.to_s
    end

    def set_connection_options(base_url, ca_file, keep_alive_timeout)
      @base_uri = URI.parse(base_url)
      @ca_file = ca_file
      @keep_alive_timeout = keep_alive_timeout
    end

    # Absolute URL for the adapter: base_url ORIGIN (scheme, host, port) + the
    # relative path. Any path/trailing-slash on base_url is ignored, matching the
    # pre-adapter behavior of opening by host:port and sending the path alone.
    def request_url(relative_path)
      origin = "#{@base_uri.scheme}://#{@base_uri.host}"
      origin += ":#{@base_uri.port}" unless @base_uri.port == @base_uri.default_port
      origin + relative_path
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

    def scope_by_site(path, options)
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

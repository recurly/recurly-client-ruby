require "net/https"

module Recurly
  module HTTP
    # The default transport adapter, backed by +Net::HTTP+. It uses the shared
    # connection pool passed in at construction (it does NOT own a private pool)
    # and preserves the byte-identical behavior the client had before the adapter
    # seam was introduced.
    class DefaultHttpAdapter < Adapter
      # @param connection_pool [Recurly::ConnectionPool] the shared, class-level pool
      # @param keep_alive_timeout [Integer] seconds; forwarded to the pool
      # @param ca_file [String, nil] CA bundle path; forwarded to the pool
      # @param timeout [Integer] read timeout in milliseconds (default 60_000 == 60s)
      # @param open_timeout [Integer] open timeout in milliseconds (default 20_000 == 20s)
      # @param logger [Logger, nil] optional logger (reserved; client owns logging today)
      def initialize(connection_pool:, keep_alive_timeout:, ca_file: nil, timeout: 60_000, open_timeout: 20_000, logger: nil)
        @connection_pool = connection_pool
        @keep_alive_timeout = keep_alive_timeout
        @ca_file = ca_file
        @read_timeout = timeout / 1000.0
        @open_timeout = open_timeout / 1000.0
        @logger = logger
      end

      # @param method [String] a {HttpMethod} constant
      # @param url [String] the ABSOLUTE request url (scheme+host+path+query)
      # @param headers [Hash] app-level request headers
      # @param body [String, nil] serialized request body
      # @param open_timeout [Numeric, nil] per-request open timeout override (seconds)
      # @param read_timeout [Numeric, nil] per-request read timeout override (seconds)
      # @return [Recurly::HTTP::AdapterResponse]
      # @raise [Recurly::Errors::TransportError] on any transport-level failure
      def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
        uri = URI.parse(url)
        request = build_request(method, uri, headers, body)

        net_response = @connection_pool.with_connection(uri: uri, keep_alive_timeout: @keep_alive_timeout, ca_file: @ca_file) do |http|
          http.open_timeout = open_timeout || @open_timeout
          http.read_timeout = read_timeout || @read_timeout
          http.start unless http.started?
          http.request(request)
        end

        to_adapter_response(net_response)
      rescue Net::OpenTimeout, Errno::ETIMEDOUT => ex
        raise Recurly::Errors::TransportError.new("Request timed out", kind: :timeout, cause: ex)
      rescue Timeout::Error => ex
        # Net::ReadTimeout < Timeout::Error. This clause MUST precede the
        # StandardError clause so read timeouts map to :timeout (invariant A).
        raise Recurly::Errors::TransportError.new("Request timed out", kind: :timeout, cause: ex)
      rescue Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::EHOSTUNREACH, Errno::ECONNABORTED,
             Errno::EPIPE, EOFError, SocketError => ex
        raise Recurly::Errors::TransportError.new("Failed to connect to Recurly: #{ex.message}", kind: :connection, cause: ex)
      rescue OpenSSL::SSL::SSLError => ex
        raise Recurly::Errors::TransportError.new(ex.message, kind: :ssl, cause: ex)
      rescue StandardError => ex
        raise Recurly::Errors::TransportError.new(ex.message, kind: :network, cause: ex)
      end

      private

      NET_VERBS = {
        HttpMethod::GET => Net::HTTP::Get,
        HttpMethod::HEAD => Net::HTTP::Head,
        HttpMethod::POST => Net::HTTP::Post,
        HttpMethod::PUT => Net::HTTP::Put,
        HttpMethod::DELETE => Net::HTTP::Delete,
      }.freeze

      def build_request(method, uri, headers, body)
        verb = NET_VERBS.fetch(method) do
          raise ArgumentError, "Unsupported HTTP method: #{method.inspect}"
        end
        # Net verbs take a path (+ query), NOT an absolute url.
        request = verb.new(uri.request_uri)
        request.body = body unless body.nil?
        (headers || {}).each { |k, v| request[k] = v }
        request
      end

      def to_adapter_response(net_response)
        response_headers = {}
        net_response.each_header { |k, v| response_headers[k.downcase] = v }

        AdapterResponse.new(
          status_code: net_response.code.to_i,
          headers: response_headers,
          body: net_response.body,
          reason_phrase: net_response.message,
        )
      end
    end
  end
end

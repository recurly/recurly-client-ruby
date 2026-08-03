module Recurly
  module Errors
    class NetworkError < APIError; end
    class ConnectionFailedError < NetworkError; end
    class SSLError < NetworkError; end

    # Neutral transport error raised by HTTP adapters for ALL transport-level
    # failures (timeouts, connection failures, SSL errors, generic network
    # errors). This is the single error class the client's retry loop rescues.
    #
    # The +kind+ symbol (+:timeout+, +:connection+, +:ssl+, +:network+) lets the
    # client reproduce its historical typed-error mapping after retries are
    # exhausted, without needing to know about adapter-specific exception classes.
    # Custom adapters that only set +:network+ degrade gracefully to +NetworkError+.
    class TransportError < NetworkError
      # @return [Symbol] one of +:timeout+, +:connection+, +:ssl+, +:network+
      attr_reader :kind

      # @return [Exception, nil] the underlying transport exception, if any.
      #   Named distinctly from Ruby's built-in +Exception#cause+ (which is
      #   auto-populated on +raise+ inside a +rescue+ and read by Sentry,
      #   logging frameworks, and +pp+) so we don't shadow it.
      attr_reader :original_exception

      def initialize(message, kind: :network, cause: nil)
        super(message)
        @kind = kind
        @original_exception = cause
      end
    end
  end
end

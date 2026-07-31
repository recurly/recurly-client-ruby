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

      # @return [Exception, nil] the underlying transport exception, if any
      attr_reader :cause

      def initialize(message, kind: :network, cause: nil)
        super(message)
        @kind = kind
        @cause = cause
      end
    end
  end
end

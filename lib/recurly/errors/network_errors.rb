module Recurly
  module Errors
    class NetworkError < StandardError; end
    class TimeoutError < NetworkError; end
    class ConnectionFailed < NetworkError; end
    class SSLError < NetworkError; end
  end
end

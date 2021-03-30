module Recurly
  module Errors
    class NetworkError < APIError; end
    class ConnectionFailedError < NetworkError; end
    class SSLError < NetworkError; end
  end
end

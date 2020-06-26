module Recurly
  module Errors
    class NetworkError < StandardError; end
    class InvalidResponseError < NetworkError; end
    class TimeoutError < NetworkError; end
    class ConnectionFailedError < NetworkError; end
    class SSLError < NetworkError; end
    class UnavailableError < NetworkError; end

    # Missing generic 5XX -> UnavailableError
    ERROR_MAP = {
      "400" => "BadRequestError",
      "401" => "UnauthorizedError",
      "403" => "UnauthorizedError",
      "408" => "TimeoutError",
      "429" => "RateLimitedError",
      "500" => "InternalServerError",
      "503" => "UnavailableError",
      "504" => "TimeoutError",
    }
  end
end

module Recurly
  module HTTP
    # String constants for the HTTP methods the client issues. Used as the
    # +method+ argument crossing the adapter seam (`#call(method, ...)`).
    module HttpMethod
      GET = "GET".freeze
      POST = "POST".freeze
      PUT = "PUT".freeze
      DELETE = "DELETE".freeze
      HEAD = "HEAD".freeze
    end
  end
end

module Recurly
  module HTTP
    class Response
      attr_accessor :status, :body, :request,
        :request_id, :rate_limit, :rate_limit_remaining,
        :rate_limit_reset, :date, :proxy_metadata

      def initialize(resp, request)
        @request = request
        @status = resp.status
        @request_id = resp.headers["x-request-id"]
        @rate_limit = resp.headers["x-ratelimit-limit"].to_i
        @rate_limit_remaining = resp.headers["x-ratelimit-remaining"].to_i
        @rate_limit_reset = Time.at(resp.headers["x-ratelimit-reset"].to_i).to_datetime
        if resp.body && !resp.body.empty?
          @body = resp.body
        else
          @body = nil
        end
      end
    end

    class Request
      attr_accessor :method, :path, :body

      def initialize(method, path, body = nil)
        @method = method
        @path = path
        if body && !body.empty?
          @body = body
        else
          @body = nil
        end
      end

      def ==(other)
        method == other.method \
          && path == other.path \
          && body == other.body
      end
    end
  end
end

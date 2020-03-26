module Recurly
  module HTTP
    class Response
      attr_accessor :status, :body, :request,
        :request_id, :rate_limit, :rate_limit_remaining,
        :rate_limit_reset, :date, :proxy_metadata,
        :content_type

      def initialize(resp, request)
        @request = Request.new(request.method, request.path, request.body)
        @status = resp.code.to_i
        @request_id = resp["x-request-id"]
        @rate_limit = resp["x-ratelimit-limit"].to_i
        @rate_limit_remaining = resp["x-ratelimit-remaining"].to_i
        @rate_limit_reset = Time.at(resp["x-ratelimit-reset"].to_i).to_datetime
        if resp["content-type"]
          @content_type = resp["content-type"].split(";").first
        else
          @content_type = resp.content_type
        end
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

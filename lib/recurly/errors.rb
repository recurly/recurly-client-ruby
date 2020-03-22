module Recurly
  module Errors
    class APIError < StandardError
      # @!attribute recurly_error
      #   @return [Recurly::Resources::Error] The {Recurly::Resources::Error} object
      attr_reader :recurly_error

      # Looks up an Error class by name
      # @example
      #   Errors.error_class('BadRequestError')
      #   #=> Errors::BadRequestError
      # @param error_key [String]
      # @return [Errors::APIError,Errors::NetworkError]
      def self.error_class(error_key)
        class_name = error_key.split("_").map(&:capitalize).join
        class_name += "Error" unless class_name.end_with?("Error")
        Errors.const_get(class_name)
      end

      # When the response does not have a JSON body, this determines the appropriate
      # Error class based on the response code. This may occur when a load balancer
      # returns an error before it reaches Recurly's API.
      # @param response [Net::Response]
      # @return [Errors::APIError,Errors::NetworkError]
      # rubocop:disable Metrics/CyclomaticComplexity
      def self.from_response(response)
        case response
        when Net::HTTPBadRequest # 400
          Recurly::Errors::BadRequestError
        when Net::HTTPUnauthorized, Net::HTTPForbidden # 401, 403
          Recurly::Errors::UnauthorizedError
        when Net::HTTPRequestTimeOut # 408
          Recurly::Errors::TimeoutError
        when Net::HTTPTooManyRequests # 429
          Recurly::Errors::RateLimitedError
        when Net::HTTPInternalServerError # 500
          Recurly::Errors::InternalServerError
        when Net::HTTPServiceUnavailable # 503
          Recurly::Errors::UnavailableError
        when Net::HTTPGatewayTimeOut # 504
          Recurly::Errors::TimeoutError
        when Net::HTTPServerError # 5xx
          Recurly::Errors::UnavailableError
        else
          Recurly::Errors::APIError
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity

      def initialize(response, error)
        super(error.message)
        @response = response
        @recurly_error = error
      end

      def status_code
        @response.status
      end

      def get_response
        @response
      end
    end
  end

  require_relative "./errors/api_errors"
  require_relative "./errors/network_errors"
end

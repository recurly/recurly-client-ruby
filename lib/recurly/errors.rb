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
      # @return [Errors::APIError]
      def self.from_response(response)
        if Recurly::Errors::ERROR_MAP.has_key?(response.code)
          Recurly::Errors.const_get(Recurly::Errors::ERROR_MAP[response.code])
        else
          Recurly::Errors::APIError
        end
      end

      def initialize(message, response = nil, error = nil)
        super(message)
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
  require_relative "./errors/webhooks_errors"
end

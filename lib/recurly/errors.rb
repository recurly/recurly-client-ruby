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
        class_name = error_key.split('_').map(&:capitalize).join
        class_name += "Error" unless class_name.end_with?("Error")
        Errors.const_get(class_name)
      end

      def initialize(response, error)
        super(error.message)
        @response = response
        @recurly_error = error
      end

      def status_code
        @response.status
      end
    end
  end

  require_relative "./errors/api_errors"
  require_relative "./errors/network_errors"
end

module Recurly
  module Resources
    class ErrorMayHaveTransaction < Resource

      # @!attribute message
      #   @return [String] Message
      define_attribute :message, String

      # @!attribute params
      #   @return [Array[String]] Parameter specific errors
      define_attribute :params, Array, {:item_type => String}

      # @!attribute transaction_error
      #   @return [Hash] This is only included on errors with `type=transaction`.
      define_attribute :transaction_error, Hash

      # @!attribute type
      #   @return [String] Type
      define_attribute :type, String, {:enum => ["bad_request", "internal_server_error", "immutable_subscription", "invalid_api_key", "invalid_api_version", "invalid_content_type", "invalid_permissions", "invalid_token", "not_found", "simultaneous_request", "transaction", "unauthorized", "unavailable_in_api_version", "unknown_api_version", "validation", "missing_feature"]}
    end
  end
end

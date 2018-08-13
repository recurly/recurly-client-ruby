module Recurly
  module Resources
    class Error < Resource

      # @!attribute message
      #   @return [String] Message
      define_attribute :message, String

      # @!attribute params
      #   @return [Array[Hash]] Parameter specific errors
      define_attribute :params, Array, {:item_type => Hash}

      # @!attribute type
      #   @return [String] Type
      define_attribute :type, String, {:enum => ["bad_request", "internal_server_error", "immutable_subscription", "invalid_api_key", "invalid_api_version", "invalid_content_type", "invalid_permissions", "invalid_token", "not_found", "simultaneous_request", "transaction", "unauthorized", "unavailable_in_api_version", "unknown_api_version", "validation", "missing_feature"]}
    end
  end
end

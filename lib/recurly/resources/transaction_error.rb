# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TransactionError < Resource

      # @!attribute category
      #   @return [String] Category
      define_attribute :category, String

      # @!attribute code
      #   @return [String] Code
      define_attribute :code, String

      # @!attribute decline_code
      #   @return [String] Decline code
      define_attribute :decline_code, String

      # @!attribute merchant_advice
      #   @return [String] Merchant message
      define_attribute :merchant_advice, String

      # @!attribute message
      #   @return [String] Customer message
      define_attribute :message, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute three_d_secure_action_token_id
      #   @return [String] Returned when 3-D Secure authentication is required for a transaction. Pass this value to Recurly.js so it can continue the challenge flow.
      define_attribute :three_d_secure_action_token_id, String

      # @!attribute transaction_id
      #   @return [String] Transaction ID
      define_attribute :transaction_id, String
    end
  end
end

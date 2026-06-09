# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryTransactionCreate < Request

      # @!attribute attempted_collection_date
      #   @return [DateTime] The date the original payment collection was attempted.
      define_attribute :attempted_collection_date, DateTime

      # @!attribute gateway_error_code
      #   @return [String] The error code returned by the payment gateway for the original payment collection attempt.
      define_attribute :gateway_error_code, String

      # @!attribute merchant_advice_code
      #   @return [String] The advice code returned by the payment gateway for the original payment collection attempt. This field is only applicable for certain gateways.
      define_attribute :merchant_advice_code, String
    end
  end
end

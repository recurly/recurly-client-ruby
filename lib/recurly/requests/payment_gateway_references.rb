# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PaymentGatewayReferences < Request

      # @!attribute reference_type
      #   @return [String] The type of reference token. Required if token is passed in for Stripe Gateway or Ebanx UPI.
      define_attribute :reference_type, String

      # @!attribute token
      #   @return [String] Reference value used when the external token was created. If a Stripe gateway or Ebanx gateway is used, this value will need to be accompanied by its reference_type.
      define_attribute :token, String
    end
  end
end

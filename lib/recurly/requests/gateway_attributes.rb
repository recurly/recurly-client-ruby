# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class GatewayAttributes < Request

      # @!attribute account_reference
      #   @return [String] Used by Adyen and Braintree gateways. For Adyen the Shopper Reference value used when the external token was created. Must be used in conjunction with gateway_token and gateway_code. For Braintree the PayPal PayerID is populated in the response.
      define_attribute :account_reference, String
    end
  end
end

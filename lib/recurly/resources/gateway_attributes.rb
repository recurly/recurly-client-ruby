# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class GatewayAttributes < Resource

      # @!attribute account_reference
      #   @return [String] Used by Adyen gateways. The Shopper Reference value used when the external token was created.
      define_attribute :account_reference, String
    end
  end
end

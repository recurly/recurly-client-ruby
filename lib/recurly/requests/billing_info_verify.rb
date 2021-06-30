# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class BillingInfoVerify < Request

      # @!attribute gateway_code
      #   @return [String] An identifier for a specific payment gateway.
      define_attribute :gateway_code, String
    end
  end
end

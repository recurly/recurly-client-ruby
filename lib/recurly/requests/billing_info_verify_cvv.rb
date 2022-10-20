# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class BillingInfoVerifyCVV < Request

      # @!attribute verification_value
      #   @return [String] Unique security code for a credit card.
      define_attribute :verification_value, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountAcquisitionCost < Resource

      # @!attribute amount
      #   @return [Float] The amount of the corresponding currency used to acquire the account.
      define_attribute :amount, Float

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String
    end
  end
end

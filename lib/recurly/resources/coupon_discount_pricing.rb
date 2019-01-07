# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please file a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponDiscountPricing < Resource

      # @!attribute amount
      #   @return [Float] Value of the fixed discount that this coupon applies.
      define_attribute :amount, Float

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String
    end
  end
end

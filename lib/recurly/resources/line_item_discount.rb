# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class LineItemDiscount < Resource

      # @!attribute coupon_id
      #   @return [String] The ID of the coupon that generated this discount.
      define_attribute :coupon_id, String

      # @!attribute coupon_redemption_id
      #   @return [String] The ID of the coupon redemption that generated this discount.
      define_attribute :coupon_redemption_id, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute discount_amount
      #   @return [Float] The amount discounted on this line item by this coupon redemption.
      define_attribute :discount_amount, Float

      # @!attribute object
      #   @return [String] Will always be `line_item_discount`.
      define_attribute :object, String

      # @!attribute order_applied
      #   @return [Integer] The order in which this discount was applied when multiple coupons were redeemed.
      define_attribute :order_applied, Integer
    end
  end
end

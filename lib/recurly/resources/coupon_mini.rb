# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponMini < Resource

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute coupon_type
      #   @return [String] Whether the coupon is "single_code" or "bulk". Bulk coupons will require a `unique_code_template` and will generate unique codes through the `/generate` endpoint.
      define_attribute :coupon_type, String

      # @!attribute discount
      #   @return [CouponDiscount] Details of the discount a coupon applies. Will contain a `type` property and one of the following properties: `percent`, `fixed`, `trial`.
      define_attribute :discount, :CouponDiscount

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute id
      #   @return [String] Coupon ID
      define_attribute :id, String

      # @!attribute name
      #   @return [String] The internal name for the coupon.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute state
      #   @return [String] Indicates if the coupon is redeemable, and if it is not, why.
      define_attribute :state, String
    end
  end
end

module Recurly
  module Resources
    class CouponMini < Resource

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute coupon_type
      #   @return [String] Whether the coupon is "single_code" or "bulk". Bulk coupons will require a `unique_code_template` and will generate unique codes through the `/generate` endpoint.
      define_attribute :coupon_type, String, {:enum => ["single_code", "bulk"]}

      # @!attribute discount
      #   @return [CouponDiscount]
      define_attribute :discount, :CouponDiscount

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute [r] id
      #   @return [String] Coupon ID
      define_attribute :id, String, {:read_only => true}

      # @!attribute name
      #   @return [String] The internal name for the coupon.
      define_attribute :name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only => true}

      # @!attribute state
      #   @return [String] Indicates if the coupon is redeemable, and if it is not, why.
      define_attribute :state, String, {:enum => ["redeemable", "maxed_out", "expired"]}
    end
  end
end

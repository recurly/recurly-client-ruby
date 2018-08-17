module Recurly
  module Requests
    class CouponRedemptionCreate < Request

      # @!attribute coupon_id
      #   @return [String] Coupon ID
      define_attribute :coupon_id, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String
    end
  end
end

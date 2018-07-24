module Recurly
  module Resources
    class CouponRedemptionMini < Resource

      # @!attribute coupon
      #   @return [Coupon]
      define_attribute :coupon, :Coupon

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, {:read_only => true}

      # @!attribute discounted
      #   @return [String] The amount that was discounted upon the application of the coupon, formatted with the currency.
      define_attribute :discounted, String

      # @!attribute [r] id
      #   @return [String] Coupon Redemption ID
      define_attribute :id, String, {:read_only => true}

      # @!attribute [r] object
      #   @return [String] Will always be `coupon`.
      define_attribute :object, String, {:read_only => true}

      # @!attribute state
      #   @return [String] Invoice state
      define_attribute :state, String, {:enum => ["active", "inactive"]}
    end
  end
end

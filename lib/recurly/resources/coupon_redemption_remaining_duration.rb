# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponRedemptionRemainingDuration < Resource

      # @!attribute expires_at
      #   @return [DateTime] Present when `type` is `temporal`. The datetime after which this redemption will no longer apply.
      define_attribute :expires_at, DateTime

      # @!attribute redemptions_remaining
      #   @return [Integer] The number of redemption periods remaining for which this coupon will still apply.
      define_attribute :redemptions_remaining, Integer

      # @!attribute type
      #   @return [String] The coupon's duration type. `temporal` includes an `expires_at` timestamp. `billing_periods` includes a `redemptions_remaining` count of billing cycles. `forever` and `single_use` have no additional fields.
      define_attribute :type, String
    end
  end
end

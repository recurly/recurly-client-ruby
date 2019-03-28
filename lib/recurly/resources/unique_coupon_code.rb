# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class UniqueCouponCode < Resource

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, { :read_only => true }

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute [r] id
      #   @return [String] Unique Coupon Code ID
      define_attribute :id, String, { :read_only => true }

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }

      # @!attribute [r] redeemed_at
      #   @return [DateTime] The date and time the unique coupon code was redeemed.
      define_attribute :redeemed_at, DateTime, { :read_only => true }

      # @!attribute state
      #   @return [String] Indicates if the unique coupon code is redeemable or why not.
      define_attribute :state, String, { :enum => ["redeemable", "maxed_out", "expired", "inactive"] }

      # @!attribute [r] updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime, { :read_only => true }
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class UniqueCouponCode < Resource

      # @!attribute bulk_coupon_code
      #   @return [String] The Coupon code of the parent Bulk Coupon
      define_attribute :bulk_coupon_code, String

      # @!attribute bulk_coupon_id
      #   @return [String] The Coupon ID of the parent Bulk Coupon
      define_attribute :bulk_coupon_id, String

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute id
      #   @return [String] Unique Coupon Code ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute redeemed_at
      #   @return [DateTime] The date and time the unique coupon code was redeemed.
      define_attribute :redeemed_at, DateTime

      # @!attribute state
      #   @return [String] Indicates if the unique coupon code is redeemable or why not.
      define_attribute :state, String

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime
    end
  end
end

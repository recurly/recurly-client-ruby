# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponRedemption < Resource

      # @!attribute account_id
      #   @return [String] The Account ID on which the coupon was applied.
      define_attribute :account_id, String

      # @!attribute coupon
      #   @return [Coupon]
      define_attribute :coupon, :Coupon

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute discounted
      #   @return [String] The amount that was discounted upon the application of the coupon, formatted with the currency.
      define_attribute :discounted, String

      # @!attribute id
      #   @return [String] Coupon Redemption ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Will always be `coupon`.
      define_attribute :object, String

      # @!attribute removed_at
      #   @return [DateTime] The date and time the redemption was removed from the account (un-redeemed).
      define_attribute :removed_at, DateTime

      # @!attribute state
      #   @return [String] Coupon Redemption state
      define_attribute :state, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

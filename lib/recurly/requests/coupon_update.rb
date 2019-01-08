# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class CouponUpdate < Request

      # @!attribute hosted_description
      #   @return [String] This description will show up when a customer redeems a coupon on your Hosted Payment Pages, or if you choose to show the description on your own checkout page.
      define_attribute :hosted_description, String

      # @!attribute invoice_description
      #   @return [String] Description of the coupon on the invoice.
      define_attribute :invoice_description, String

      # @!attribute max_redemptions
      #   @return [Integer] A maximum number of redemptions for the coupon. The coupon will expire when it hits its maximum redemptions.
      define_attribute :max_redemptions, Integer

      # @!attribute max_redemptions_per_account
      #   @return [Integer] Redemptions per account is the number of times a specific account can redeem the coupon. Set redemptions per account to `1` if you want to keep customers from gaming the system and getting more than one discount from the coupon campaign.
      define_attribute :max_redemptions_per_account, Integer

      # @!attribute name
      #   @return [String] The internal name for the coupon.
      define_attribute :name, String

      # @!attribute redeem_by_date
      #   @return [String] The date and time the coupon will expire and can no longer be redeemed. Time is always 11:59:59, the end-of-day Pacific time.
      define_attribute :redeem_by_date, String
    end
  end
end

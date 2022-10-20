# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class CouponRedemptionCreate < Request
      
      # @!attribute coupon_id
      #   @return [String] Coupon ID
      define_attribute :coupon_id, String
      
      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String
      
      # @!attribute subscription_id
      #   @return [String] Subscription ID
      define_attribute :subscription_id, String
      
    end
  end
end

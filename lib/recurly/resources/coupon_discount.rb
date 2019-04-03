# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponDiscount < Resource

      # @!attribute currencies
      #   @return [Array[CouponDiscountPricing]]
      define_attribute :currencies, Array, { :item_type => :CouponDiscountPricing }

      # @!attribute percent
      #   @return [Integer]
      define_attribute :percent, Integer

      # @!attribute trial
      #   @return [Hash]
      define_attribute :trial, Hash

      # @!attribute type
      #   @return [String]
      define_attribute :type, String, { :enum => ["percent", "fixed", "free_trial"] }
    end
  end
end

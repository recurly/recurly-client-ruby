# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponDiscount < Resource

      # @!attribute currencies
      #   @return [Array[CouponDiscountPricing]] This is only present when `type=fixed`.
      define_attribute :currencies, Array, {:item_type => :CouponDiscountPricing}

      # @!attribute percent
      #   @return [Integer] This is only present when `type=percent`.
      define_attribute :percent, Integer

      # @!attribute trial
      #   @return [Hash] This is only present when `type=free_trial`.
      define_attribute :trial, Hash

      # @!attribute type
      #   @return [String]
      define_attribute :type, String, {:enum => ["percent", "fixed", "free_trial"]}
    end
  end
end

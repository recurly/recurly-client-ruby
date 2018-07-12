module Recurly
  module Resources
    class CouponDiscount < Resource

      # @!attribute currencies
      #   @return [Array[String]] This is only present when `type=fixed`.
      define_attribute :currencies, Array, {:item_type=>String}

      # @!attribute percent
      #   @return [Integer] This is only present when `type=percent`.
      define_attribute :percent, Integer

      # @!attribute trial
      #   @return [Hash] This is only present when `type=free_trial`.
      define_attribute :trial, Hash

      # @!attribute type
      #   @return [String]
      define_attribute :type, String, {:enum=>["percent", "fixed", "free_trial"]}

    end
  end
end

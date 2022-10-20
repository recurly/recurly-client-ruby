# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Tier < Resource
      
      # @!attribute currencies
      #   @return [Array[TierPricing]] Tier pricing
      define_attribute :currencies, Array, {:item_type=>:TierPricing}
      
      # @!attribute ending_quantity
      #   @return [Integer] Ending quantity for the tier.  This represents a unit amount for unit-priced add ons. Must be left empty if it is the final tier.
      define_attribute :ending_quantity, Integer
      
      # @!attribute usage_percentage
      #   @return [String] (deprecated) -- Use the percentage_tiers object instead.
      define_attribute :usage_percentage, String
      
    end
  end
end

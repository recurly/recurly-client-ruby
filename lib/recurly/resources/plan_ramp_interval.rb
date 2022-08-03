# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PlanRampInterval < Resource

      # @!attribute currencies
      #   @return [Array[PlanRampPricing]] Represents the price for the ramp interval.
      define_attribute :currencies, Array, { :item_type => :PlanRampPricing }

      # @!attribute starting_billing_cycle
      #   @return [Integer] Represents the first billing cycle of a ramp.
      define_attribute :starting_billing_cycle, Integer
    end
  end
end

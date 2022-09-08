# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionRampIntervalResponse < Resource

      # @!attribute remaining_billing_cycles
      #   @return [Integer] Represents how many billing cycles are left in a ramp interval.
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute starting_billing_cycle
      #   @return [Integer] Represents the billing cycle where a ramp interval starts.
      define_attribute :starting_billing_cycle, Integer

      # @!attribute unit_amount
      #   @return [Float] Represents the price for the ramp interval.
      define_attribute :unit_amount, Float
    end
  end
end

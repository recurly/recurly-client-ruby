# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionRampIntervalResponse < Resource

      # @!attribute ending_on
      #   @return [DateTime] Date the ramp interval ends
      define_attribute :ending_on, DateTime

      # @!attribute remaining_billing_cycles
      #   @return [Integer] Represents how many billing cycles are left in a ramp interval.
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute starting_billing_cycle
      #   @return [Integer] Represents the billing cycle where a ramp interval starts.
      define_attribute :starting_billing_cycle, Integer

      # @!attribute starting_on
      #   @return [DateTime] Date the ramp interval starts
      define_attribute :starting_on, DateTime

      # @!attribute unit_amount
      #   @return [Integer] Represents the price for the ramp interval.
      define_attribute :unit_amount, Integer
    end
  end
end

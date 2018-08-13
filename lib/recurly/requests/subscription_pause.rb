module Recurly
  module Requests
    class SubscriptionPause < Request

      # @!attribute remaining_pause_cycles
      #   @return [Integer] Number of billing cycles to pause the subscriptions.
      define_attribute :remaining_pause_cycles, Integer
    end
  end
end

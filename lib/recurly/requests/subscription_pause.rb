# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionPause < Request

      # @!attribute remaining_pause_cycles
      #   @return [Integer] Number of billing cycles to pause the subscriptions.
      define_attribute :remaining_pause_cycles, Integer
    end
  end
end

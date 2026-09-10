# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningCycleWrite < Request

      # @!attribute active
      #   @return [Boolean] Only meaningful on the `trial` cycle, where sending `false` removes it. Other cycle types cannot be deactivated.
      define_attribute :active, :Boolean

      # @!attribute applies_to_manual_trial
      #   @return [Boolean] Whether the dunning settings will be applied to manual trials. Only applies to trial cycles.
      define_attribute :applies_to_manual_trial, :Boolean

      # @!attribute expire_subscription
      #   @return [Boolean] Whether the subscription(s) should be cancelled at the end of the dunning cycle.
      define_attribute :expire_subscription, :Boolean

      # @!attribute external_payment_recovery_extension_days
      #   @return [Integer] Number of days to extend external payment recovery. Only available when the site has external payment retries enabled.
      define_attribute :external_payment_recovery_extension_days, Integer

      # @!attribute fail_invoice
      #   @return [Boolean] Whether the invoice should be failed at the end of the dunning cycle.
      define_attribute :fail_invoice, :Boolean

      # @!attribute intervals
      #   @return [Array[DunningIntervalWrite]] Dunning intervals. Required unless `active` is `false`.
      define_attribute :intervals, Array, { :item_type => :DunningIntervalWrite }

      # @!attribute send_immediately_on_hard_decline
      #   @return [Boolean] Whether or not to send an extra email immediately to customers whose initial payment attempt fails with either a hard decline or invalid billing info.
      define_attribute :send_immediately_on_hard_decline, :Boolean

      # @!attribute type
      #   @return [String] The type of invoice this cycle applies to.
      define_attribute :type, String
    end
  end
end

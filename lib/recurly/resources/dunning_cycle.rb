# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class DunningCycle < Resource

      # @!attribute applies_to_manual_trial
      #   @return [Boolean] Whether the dunning settings will be applied to manual trials. Only applies to trial cycles.
      define_attribute :applies_to_manual_trial, :Boolean

      # @!attribute created_at
      #   @return [DateTime] When the current settings were created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute expire_subscription
      #   @return [Boolean] Whether the subscription(s) should be cancelled at the end of the dunning cycle.
      define_attribute :expire_subscription, :Boolean

      # @!attribute fail_invoice
      #   @return [Boolean] Whether the invoice should be failed at the end of the dunning cycle.
      define_attribute :fail_invoice, :Boolean

      # @!attribute first_communication_interval
      #   @return [Integer] The number of days after a transaction failure before the first dunning email is sent.
      define_attribute :first_communication_interval, Integer

      # @!attribute intervals
      #   @return [Array[DunningInterval]] Dunning intervals.
      define_attribute :intervals, Array, { :item_type => :DunningInterval }

      # @!attribute send_immediately_on_hard_decline
      #   @return [Boolean] Whether or not to send an extra email immediately to customers whose initial payment attempt fails with either a hard decline or invalid billing info.
      define_attribute :send_immediately_on_hard_decline, :Boolean

      # @!attribute total_dunning_days
      #   @return [Integer] The number of days between the first dunning email being sent and the end of the dunning cycle.
      define_attribute :total_dunning_days, Integer

      # @!attribute total_recycling_days
      #   @return [Integer] The number of days between a transaction failure and the end of the dunning cycle.
      define_attribute :total_recycling_days, Integer

      # @!attribute type
      #   @return [String] The type of invoice this cycle applies to.
      define_attribute :type, String

      # @!attribute updated_at
      #   @return [DateTime] When the current settings were updated in Recurly.
      define_attribute :updated_at, DateTime

      # @!attribute version
      #   @return [Integer] Current campaign version.
      define_attribute :version, Integer
    end
  end
end

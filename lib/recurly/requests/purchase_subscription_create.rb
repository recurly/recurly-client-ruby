# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PurchaseSubscriptionCreate < Request

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOnCreate]] Add-ons
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOnCreate }

      # @!attribute auto_renew
      #   @return [Boolean] Whether the subscription renews at the end of its term.
      define_attribute :auto_renew, :Boolean

      # @!attribute custom_fields
      #   @return [Array[CustomField]]
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute next_bill_date
      #   @return [DateTime] If present, this sets the date the subscription's next billing period will start (`current_period_ends_at`). This can be used to align the subscription’s billing to a specific day of the month. The initial invoice will be prorated for the period between the subscription's activation date and the billing period end date. Subsequent periods will be based off the plan interval. For a subscription with a trial period, this will change when the trial expires.
      define_attribute :next_bill_date, DateTime

      # @!attribute plan_code
      #   @return [String] Plan code
      define_attribute :plan_code, String

      # @!attribute plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity of 1.
      define_attribute :quantity, Integer

      # @!attribute renewal_billing_cycles
      #   @return [Integer] If `auto_renew=true`, when a term completes, `total_billing_cycles` takes this value as the length of subsequent terms. Defaults to the plan's `total_billing_cycles`.
      define_attribute :renewal_billing_cycles, Integer

      # @!attribute shipping_address
      #   @return [Hash] Create a shipping address on the account and assign it to the subscription.
      define_attribute :shipping_address, Hash

      # @!attribute shipping_address_id
      #   @return [String] Assign a shipping address from the account's existing shipping addresses. If this and `shipping_address` are both present, `shipping_address` will take precedence.
      define_attribute :shipping_address_id, String

      # @!attribute total_billing_cycles
      #   @return [Integer] The number of cycles/billing periods in a term. When `remaining_billing_cycles=0`, if `auto_renew=true` the subscription will renew and a new term will begin, otherwise the subscription will expire.
      define_attribute :total_billing_cycles, Integer

      # @!attribute trial_ends_at
      #   @return [DateTime] If set, overrides the default trial behavior for the subscription. The date must be in the future.
      define_attribute :trial_ends_at, DateTime

      # @!attribute unit_amount
      #   @return [Float] Override the unit amount of the subscription plan by setting this value in cents. If not provided, the subscription will inherit the price from the subscription plan for the provided currency.
      define_attribute :unit_amount, Float
    end
  end
end

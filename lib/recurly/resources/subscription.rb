module Recurly
  module Resources
    class Subscription < Resource

      # @!attribute account
      #   @return [AccountMini]
      define_attribute :account, :AccountMini

      # @!attribute activated_at
      #   @return [DateTime] Activated at
      define_attribute :activated_at, DateTime

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOn]] Add-ons
      define_attribute :add_ons, Array, {:item_type=>:SubscriptionAddOn}

      # @!attribute add_ons_total
      #   @return [Float] Total price of add-ons
      define_attribute :add_ons_total, Float

      # @!attribute bank_account_authorized_at
      #   @return [DateTime] Recurring subscriptions paid with ACH will have this attribute set. This timestamp is used for alerting customers to reauthorize in 3 years in accordance with NACHA rules. If a subscription becomes inactive or the billing info is no longer a bank account, this timestamp is cleared.
      define_attribute :bank_account_authorized_at, DateTime

      # @!attribute canceled_at
      #   @return [DateTime] Canceled at
      define_attribute :canceled_at, DateTime

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String, {:enum=>["automatic", "manual"]}

      # @!attribute coupon_redemptions
      #   @return [Array[CouponRedemptionMini]] Coupon redemptions
      define_attribute :coupon_redemptions, Array, {:item_type=>:CouponRedemptionMini}

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute current_period_ends_at
      #   @return [DateTime] Current billing period ends at
      define_attribute :current_period_ends_at, DateTime

      # @!attribute current_period_started_at
      #   @return [DateTime] Current billing period started at
      define_attribute :current_period_started_at, DateTime

      # @!attribute customer_notes
      #   @return [String] Customer notes
      define_attribute :customer_notes, String

      # @!attribute expiration_reason
      #   @return [String] Expiration reason
      define_attribute :expiration_reason, String

      # @!attribute expires_at
      #   @return [DateTime] Expires at
      define_attribute :expires_at, DateTime

      # @!attribute id
      #   @return [String] Subscription ID
      define_attribute :id, String

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute pending_change
      #   @return [SubscriptionChange]
      define_attribute :pending_change, :SubscriptionChange

      # @!attribute plan
      #   @return [PlanMini]
      define_attribute :plan, :PlanMini

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute quantity
      #   @return [Integer] Subscription quantity
      define_attribute :quantity, Integer

      # @!attribute remaining_billing_cycles
      #   @return [Integer] Remaining billing cycles
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute shipping_address
      #   @return [ShippingAddress]
      define_attribute :shipping_address, :ShippingAddress

      # @!attribute state
      #   @return [String] State
      define_attribute :state, String, {:enum=>["active", "canceled", "expired", "failed", "future", "paused"]}

      # @!attribute subtotal
      #   @return [Float] Estimated total, before tax.
      define_attribute :subtotal, Float

      # @!attribute terms_and_conditions
      #   @return [String] Terms and conditions
      define_attribute :terms_and_conditions, String

      # @!attribute trial_ends_at
      #   @return [DateTime] Trial period ends at
      define_attribute :trial_ends_at, DateTime

      # @!attribute trial_started_at
      #   @return [DateTime] Trial period started at
      define_attribute :trial_started_at, DateTime

      # @!attribute unit_amount
      #   @return [Float] Subscription unit price
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime

      # @!attribute uuid
      #   @return [String] The UUID is useful for matching data with the CSV exports and building URLs into Recurly's UI.
      define_attribute :uuid, String

    end
  end
end

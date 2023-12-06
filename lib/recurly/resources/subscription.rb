# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Subscription < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute action_result
      #   @return [Hash] Action result params to be used in Recurly-JS to complete a payment when using asynchronous payment methods, e.g., Boleto, iDEAL and Sofort.
      define_attribute :action_result, Hash

      # @!attribute activated_at
      #   @return [DateTime] Activated at
      define_attribute :activated_at, DateTime

      # @!attribute active_invoice_id
      #   @return [String] The invoice ID of the latest invoice created for an active subscription.
      define_attribute :active_invoice_id, String

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOn]] Add-ons
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOn }

      # @!attribute add_ons_total
      #   @return [Float] Total price of add-ons
      define_attribute :add_ons_total, Float

      # @!attribute auto_renew
      #   @return [Boolean] Whether the subscription renews at the end of its term.
      define_attribute :auto_renew, :Boolean

      # @!attribute bank_account_authorized_at
      #   @return [DateTime] Recurring subscriptions paid with ACH will have this attribute set. This timestamp is used for alerting customers to reauthorize in 3 years in accordance with NACHA rules. If a subscription becomes inactive or the billing info is no longer a bank account, this timestamp is cleared.
      define_attribute :bank_account_authorized_at, DateTime

      # @!attribute billing_info_id
      #   @return [String] Billing Info ID.
      define_attribute :billing_info_id, String

      # @!attribute canceled_at
      #   @return [DateTime] Canceled at
      define_attribute :canceled_at, DateTime

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String

      # @!attribute converted_at
      #   @return [DateTime] When the subscription was converted from a gift card.
      define_attribute :converted_at, DateTime

      # @!attribute coupon_redemptions
      #   @return [Array[CouponRedemptionMini]] Returns subscription level coupon redemptions that are tied to this subscription.
      define_attribute :coupon_redemptions, Array, { :item_type => :CouponRedemptionMini }

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

      # @!attribute current_term_ends_at
      #   @return [DateTime] When the term ends. This is calculated by a plan's interval and `total_billing_cycles` in a term. Subscription changes with a `timeframe=renewal` will be applied on this date.
      define_attribute :current_term_ends_at, DateTime

      # @!attribute current_term_started_at
      #   @return [DateTime] The start date of the term when the first billing period starts. The subscription term is the length of time that a customer will be committed to a subscription. A term can span multiple billing periods.
      define_attribute :current_term_started_at, DateTime

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute customer_notes
      #   @return [String] Customer notes
      define_attribute :customer_notes, String

      # @!attribute expiration_reason
      #   @return [String] Expiration reason
      define_attribute :expiration_reason, String

      # @!attribute expires_at
      #   @return [DateTime] Expires at
      define_attribute :expires_at, DateTime

      # @!attribute gateway_code
      #   @return [String] If present, this subscription's transactions will use the payment gateway with this code.
      define_attribute :gateway_code, String

      # @!attribute id
      #   @return [String] Subscription ID
      define_attribute :id, String

      # @!attribute net_terms
      #   @return [Integer] Integer paired with `Net Terms Type` and representing the number of days past the current date (for `net` Net Terms Type) or days after the last day of the current month (for `eom` Net Terms Type) that the invoice will become past due. For any value, an additional 24 hours is added to ensure the customer has the entire last day to make payment before becoming past due.  For example:  If an invoice is due `net 0`, it is due 'On Receipt' and will become past due 24 hours after it's created. If an invoice is due `net 30`, it will become past due at 31 days exactly. If an invoice is due `eom 30`, it will become past due 31 days from the last day of the current month.  When `eom` Net Terms Type is passed, the value for `Net Terms` is restricted to `0, 15, 30, 45, 60, or 90`. For more information please visit our docs page (https://docs.recurly.com/docs/manual-payments#section-collection-terms)
      define_attribute :net_terms, Integer

      # @!attribute net_terms_type
      #   @return [String] Optionally supplied string that may be either `net` or `eom` (end-of-month). When `net`, an invoice becomes past due the specified number of `Net Terms` days from the current date. When `eom` an invoice becomes past due the specified number of `Net Terms` days from the last day of the current month.  This field is only available when the EOM Net Terms feature is enabled.
      define_attribute :net_terms_type, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute paused_at
      #   @return [DateTime] Null unless subscription is paused or will pause at the end of the current billing period.
      define_attribute :paused_at, DateTime

      # @!attribute pending_change
      #   @return [SubscriptionChange] Subscription Change
      define_attribute :pending_change, :SubscriptionChange

      # @!attribute plan
      #   @return [PlanMini] Just the important parts.
      define_attribute :plan, :PlanMini

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute quantity
      #   @return [Integer] Subscription quantity
      define_attribute :quantity, Integer

      # @!attribute ramp_intervals
      #   @return [Array[SubscriptionRampIntervalResponse]] The ramp intervals representing the pricing schedule for the subscription.
      define_attribute :ramp_intervals, Array, { :item_type => :SubscriptionRampIntervalResponse }

      # @!attribute remaining_billing_cycles
      #   @return [Integer] The remaining billing cycles in the current term.
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute remaining_pause_cycles
      #   @return [Integer] Null unless subscription is paused or will pause at the end of the current billing period.
      define_attribute :remaining_pause_cycles, Integer

      # @!attribute renewal_billing_cycles
      #   @return [Integer] If `auto_renew=true`, when a term completes, `total_billing_cycles` takes this value as the length of subsequent terms. Defaults to the plan's `total_billing_cycles`.
      define_attribute :renewal_billing_cycles, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute shipping
      #   @return [SubscriptionShipping] Subscription shipping details
      define_attribute :shipping, :SubscriptionShipping

      # @!attribute started_with_gift
      #   @return [Boolean] Whether the subscription was started with a gift certificate.
      define_attribute :started_with_gift, :Boolean

      # @!attribute state
      #   @return [String] State
      define_attribute :state, String

      # @!attribute subtotal
      #   @return [Float] Estimated total, before tax.
      define_attribute :subtotal, Float

      # @!attribute tax
      #   @return [Float] Only for merchants using Recurly's In-The-Box taxes.
      define_attribute :tax, Float

      # @!attribute tax_inclusive
      #   @return [Boolean] Determines whether or not tax is included in the unit amount. The Tax Inclusive Pricing feature (separate from the Mixed Tax Pricing feature) must be enabled to utilize this flag.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute tax_info
      #   @return [TaxInfo] Only for merchants using Recurly's In-The-Box taxes.
      define_attribute :tax_info, :TaxInfo

      # @!attribute terms_and_conditions
      #   @return [String] Terms and conditions
      define_attribute :terms_and_conditions, String

      # @!attribute total
      #   @return [Float] Estimated total
      define_attribute :total, Float

      # @!attribute total_billing_cycles
      #   @return [Integer] The number of cycles/billing periods in a term. When `remaining_billing_cycles=0`, if `auto_renew=true` the subscription will renew and a new term will begin, otherwise the subscription will expire.
      define_attribute :total_billing_cycles, Integer

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

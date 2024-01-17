# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionCreate < Request

      # @!attribute account
      #   @return [AccountCreate]
      define_attribute :account, :AccountCreate

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOnCreate]] Add-ons
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOnCreate }

      # @!attribute auto_renew
      #   @return [Boolean] Whether the subscription renews at the end of its term.
      define_attribute :auto_renew, :Boolean

      # @!attribute billing_info_id
      #   @return [String] The `billing_info_id` is the value that represents a specific billing info for an end customer. When `billing_info_id` is used to assign billing info to the subscription, all future billing events for the subscription will bill to the specified billing info. `billing_info_id` can ONLY be used for sites utilizing the Wallet feature.
      define_attribute :billing_info_id, String

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String

      # @!attribute coupon_codes
      #   @return [Array[String]] A list of coupon_codes to be redeemed on the subscription or account during the purchase.
      define_attribute :coupon_codes, Array, { :item_type => String }

      # @!attribute credit_customer_notes
      #   @return [String] If there are pending credits on the account that will be invoiced during the subscription creation, these will be used as the Customer Notes on the credit invoice.
      define_attribute :credit_customer_notes, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute customer_notes
      #   @return [String] This will default to the Customer Notes text specified on the Invoice Settings. Specify custom notes to add or override Customer Notes. Custom notes will stay with a subscription on all renewals.
      define_attribute :customer_notes, String

      # @!attribute gateway_code
      #   @return [String] If present, this subscription's transactions will use the payment gateway with this code.
      define_attribute :gateway_code, String

      # @!attribute gift_card_redemption_code
      #   @return [String] A gift card redemption code to be redeemed on the purchase invoice.
      define_attribute :gift_card_redemption_code, String

      # @!attribute net_terms
      #   @return [Integer] Integer paired with `Net Terms Type` and representing the number of days past the current date (for `net` Net Terms Type) or days after the last day of the current month (for `eom` Net Terms Type) that the invoice will become past due. For `manual` collection method, an additional 24 hours is added to ensure the customer has the entire last day to make payment before becoming past due. For example:  If an invoice is due `net 0`, it is due 'On Receipt' and will become past due 24 hours after it's created. If an invoice is due `net 30`, it will become past due at 31 days exactly. If an invoice is due `eom 30`, it will become past due 31 days from the last day of the current month.  For `automatic` collection method, the additional 24 hours is not added. For example, On-Receipt is due immediately, and `net 30` will become due exactly 30 days from invoice generation, at which point Recurly will attempt collection. When `eom` Net Terms Type is passed, the value for `Net Terms` is restricted to `0, 15, 30, 45, 60, or 90`.  For more information on how net terms work with `manual` collection visit our docs page (https://docs.recurly.com/docs/manual-payments#section-collection-terms) or visit (https://docs.recurly.com/docs/automatic-invoicing-terms#section-collection-terms) for information about net terms using `automatic` collection.
      define_attribute :net_terms, Integer

      # @!attribute net_terms_type
      #   @return [String] Optionally supplied string that may be either `net` or `eom` (end-of-month). When `net`, an invoice becomes past due the specified number of `Net Terms` days from the current date. When `eom` an invoice becomes past due the specified number of `Net Terms` days from the last day of the current month.  This field is only available when the EOM Net Terms feature is enabled.
      define_attribute :net_terms_type, String

      # @!attribute next_bill_date
      #   @return [DateTime] If present, this sets the date the subscription's next billing period will start (`current_period_ends_at`). This can be used to align the subscription’s billing to a specific day of the month. The initial invoice will be prorated for the period between the subscription's activation date and the billing period end date. Subsequent periods will be based off the plan interval. For a subscription with a trial period, this will change when the trial expires.
      define_attribute :next_bill_date, DateTime

      # @!attribute plan_code
      #   @return [String] You must provide either a `plan_code` or `plan_id`. If both are provided the `plan_id` will be used.
      define_attribute :plan_code, String

      # @!attribute plan_id
      #   @return [String] You must provide either a `plan_code` or `plan_id`. If both are provided the `plan_id` will be used.
      define_attribute :plan_id, String

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity of 1.
      define_attribute :quantity, Integer

      # @!attribute ramp_intervals
      #   @return [Array[SubscriptionRampInterval]] The new set of ramp intervals for the subscription.
      define_attribute :ramp_intervals, Array, { :item_type => :SubscriptionRampInterval }

      # @!attribute renewal_billing_cycles
      #   @return [Integer] If `auto_renew=true`, when a term completes, `total_billing_cycles` takes this value as the length of subsequent terms. Defaults to the plan's `total_billing_cycles`.
      define_attribute :renewal_billing_cycles, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute shipping
      #   @return [SubscriptionShippingCreate] Create a shipping address on the account and assign it to the subscription.
      define_attribute :shipping, :SubscriptionShippingCreate

      # @!attribute starts_at
      #   @return [DateTime] If set, the subscription will begin in the future on this date. The subscription will apply the setup fee and trial period, unless the plan has no trial.
      define_attribute :starts_at, DateTime

      # @!attribute tax_inclusive
      #   @return [Boolean] Determines whether or not tax is included in the unit amount. The Tax Inclusive Pricing feature (separate from the Mixed Tax Pricing feature) must be enabled to use this flag.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute terms_and_conditions
      #   @return [String] This will default to the Terms and Conditions text specified on the Invoice Settings page in your Recurly admin. Specify custom notes to add or override Terms and Conditions. Custom notes will stay with a subscription on all renewals.
      define_attribute :terms_and_conditions, String

      # @!attribute total_billing_cycles
      #   @return [Integer] The number of cycles/billing periods in a term. When `remaining_billing_cycles=0`, if `auto_renew=true` the subscription will renew and a new term will begin, otherwise the subscription will expire.
      define_attribute :total_billing_cycles, Integer

      # @!attribute transaction_type
      #   @return [String] An optional type designation for the payment gateway transaction created by this request. Supports 'moto' value, which is the acronym for mail order and telephone transactions.
      define_attribute :transaction_type, String

      # @!attribute trial_ends_at
      #   @return [DateTime] If set, overrides the default trial behavior for the subscription. When the current date time or a past date time is provided the subscription will begin with no trial phase (overriding any plan default trial). When a future date time is provided the subscription will begin with a trial phase ending at the specified date time.
      define_attribute :trial_ends_at, DateTime

      # @!attribute unit_amount
      #   @return [Float] Override the unit amount of the subscription plan by setting this value. If not provided, the subscription will inherit the price from the subscription plan for the provided currency.
      define_attribute :unit_amount, Float
    end
  end
end

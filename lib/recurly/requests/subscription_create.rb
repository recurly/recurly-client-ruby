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

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String, { :enum => ["automatic", "manual"] }

      # @!attribute coupon_code
      #   @return [String] Optional coupon code to redeem on the account and discount the subscription. Please note, the subscription request will fail if the coupon is invalid.
      define_attribute :coupon_code, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute customer_notes
      #   @return [String] This will default to the Customer Notes text specified on the Invoice Settings. Specify custom notes to add or override Customer Notes. Custom notes will stay with a subscription on all renewals.
      define_attribute :customer_notes, String

      # @!attribute first_renewal_date
      #   @return [DateTime] If set,indicates when the first renewal should occur. Subsequent renewals will be offset from this date. The first invoice will be prorated appropriately so that the customer only pays for the portion of the first billing period for which the subscription applies. Useful for forcing a subscription to renew on the first of the month.
      define_attribute :first_renewal_date, DateTime

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute plan_code
      #   @return [String] Plan code
      define_attribute :plan_code, String

      # @!attribute plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity of 1.
      define_attribute :quantity, Integer

      # @!attribute shipping_address
      #   @return [ShippingAddressCreate] Create a shipping address on the account and assign it to the subscription.
      define_attribute :shipping_address, :ShippingAddressCreate

      # @!attribute shipping_address_id
      #   @return [String] Assign a shipping address from the account's existing shipping addresses. If this and `shipping_address` are both present, `shipping_address` will take precedence.
      define_attribute :shipping_address_id, String

      # @!attribute starts_at
      #   @return [DateTime] If set, the subscription will begin in the future on this date. The subscription will apply the setup fee and trial period, unless the plan has no trial.
      define_attribute :starts_at, DateTime

      # @!attribute terms_and_conditions
      #   @return [String] This will default to the Terms and Conditions text specified on the Invoice Settings page in your Recurly admin. Specify custom notes to add or override Terms and Conditions. Custom notes will stay with a subscription on all renewals.
      define_attribute :terms_and_conditions, String

      # @!attribute total_billing_cycles
      #   @return [Integer] Renews the subscription for a specified number of total cycles, then automatically cancels. Defaults to the subscription renewing indefinitely.
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

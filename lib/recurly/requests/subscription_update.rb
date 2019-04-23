# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionUpdate < Request

      # @!attribute auto_renew
      #   @return [Boolean] Whether the subscription renews at the end of its term.
      define_attribute :auto_renew, :Boolean

      # @!attribute collection_method
      #   @return [String] Change collection method
      define_attribute :collection_method, String

      # @!attribute custom_fields
      #   @return [Array[CustomField]]
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute customer_notes
      #   @return [String] Specify custom notes to add or override Customer Notes. Custom notes will stay with a subscription on all renewals.
      define_attribute :customer_notes, String

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute next_bill_date
      #   @return [DateTime] If present, this sets the date the subscription's next billing period will start (`current_period_ends_at`). This can be used to align the subscription’s billing to a specific day of the month. For a subscription in a trial period, this will change when the trial expires.
      define_attribute :next_bill_date, DateTime

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute remaining_billing_cycles
      #   @return [Integer] The remaining billing cycles in the current term.
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute renewal_billing_cycles
      #   @return [Integer] If `auto_renew=true`, when a term completes, `total_billing_cycles` takes this value as the length of subsequent terms. Defaults to the plan's `total_billing_cycles`.
      define_attribute :renewal_billing_cycles, Integer

      # @!attribute shipping_address
      #   @return [ShippingAddressCreate] Create a shipping address on the account and assign it to the subscription. If this and `shipping_address_id` are both present, `shipping_address_id` will take precedence."
      define_attribute :shipping_address, :ShippingAddressCreate

      # @!attribute shipping_address_id
      #   @return [String] Assign a shipping address from the account's existing shipping addresses.
      define_attribute :shipping_address_id, String

      # @!attribute terms_and_conditions
      #   @return [String] Specify custom notes to add or override Terms and Conditions. Custom notes will stay with a subscription on all renewals.
      define_attribute :terms_and_conditions, String
    end
  end
end

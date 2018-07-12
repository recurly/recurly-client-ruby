module Recurly
  module Requests
    class SubscriptionUpdate < Request

      # @!attribute collection_method
      #   @return [String] Change collection method
      define_attribute :collection_method, String, {:enum => ["automatic", "manual"]}

      # @!attribute customer_notes
      #   @return [String] Specify custom notes to add or override Customer Notes. Custom notes will stay with a subscription on all renewals.
      define_attribute :customer_notes, String

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute next_renewal_at
      #   @return [DateTime] For an active subscription, this will change the next renewal date. For a subscription in a trial period, modifying the renewal date will change when the trial expires.
      define_attribute :next_renewal_at, DateTime

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute remaining_billing_cycles
      #   @return [Integer] Renews the subscription for a specified number of cycles, then automatically cancels.
      define_attribute :remaining_billing_cycles, Integer

      # @!attribute shipping_address
      #   @return [Hash] Create a shipping address on the account and assign it to the subscription. If this and `shipping_address_id` are both present, `shipping_address_id` will take precedence."
      define_attribute :shipping_address, Hash

      # @!attribute shipping_address_id
      #   @return [String] Assign a shipping address from the account's existing shipping addresses.
      define_attribute :shipping_address_id, String

      # @!attribute terms_and_conditions
      #   @return [String] Specify custom notes to add or override Terms and Conditions. Custom notes will stay with a subscription on all renewals.
      define_attribute :terms_and_conditions, String
    end
  end
end

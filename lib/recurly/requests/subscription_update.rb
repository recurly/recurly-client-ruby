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

      # @!attribute billing_info_id
      #   @return [String] The `billing_info_id` is the value that represents a specific billing info for an end customer. When `billing_info_id` is used to assign billing info to the subscription, all future billing events for the subscription will bill to the specified billing info. `billing_info_id` can ONLY be used for sites utilizing the Wallet feature.
      define_attribute :billing_info_id, String

      # @!attribute collection_method
      #   @return [String] Change collection method
      define_attribute :collection_method, String

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute customer_notes
      #   @return [String] Specify custom notes to add or override Customer Notes. Custom notes will stay with a subscription on all renewals.
      define_attribute :customer_notes, String

      # @!attribute gateway_code
      #   @return [String] If present, this subscription's transactions will use the payment gateway with this code.
      define_attribute :gateway_code, String

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute next_bill_date
      #   @return [DateTime] If present, this sets the date the subscription's next billing period will start (`current_period_ends_at`). This can be used to align the subscription’s billing to a specific day of the month. For a subscription in a trial period, this will change when the trial expires. This parameter is useful for postponement of a subscription to change its billing date without proration.
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

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute shipping
      #   @return [SubscriptionShippingUpdate] Subscription shipping details
      define_attribute :shipping, :SubscriptionShippingUpdate

      # @!attribute tax_inclusive
      #   @return [Boolean] Determines whether or not tax is included in the unit amount. The Tax Inclusive Pricing feature (separate from the Mixed Tax Pricing feature) must be enabled to use this flag.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute terms_and_conditions
      #   @return [String] Specify custom notes to add or override Terms and Conditions. Custom notes will stay with a subscription on all renewals.
      define_attribute :terms_and_conditions, String
    end
  end
end

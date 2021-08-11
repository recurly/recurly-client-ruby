# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionChangeCreate < Request

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOnUpdate]] If you provide a value for this field it will replace any existing add-ons. So, when adding or modifying an add-on, you need to include the existing subscription add-ons. Unchanged add-ons can be included just using the subscription add-on''s ID: `{"id": "abc123"}`. If this value is omitted your existing add-ons will be unaffected. To remove all existing add-ons, this value should be an empty array.'  If a subscription add-on's `code` is supplied without the `id`, `{"code": "def456"}`, the subscription add-on attributes will be set to the current values of the plan add-on unless provided in the request.  - If an `id` is passed, any attributes not passed in will pull from the   existing subscription add-on - If a `code` is passed, any attributes not passed in will pull from the   current values of the plan add-on - Attributes passed in as part of the request will override either of the   above scenarios
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOnUpdate }

      # @!attribute billing_info
      #   @return [SubscriptionChangeBillingInfoCreate]
      define_attribute :billing_info, :SubscriptionChangeBillingInfoCreate

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String

      # @!attribute coupon_codes
      #   @return [Array[String]] A list of coupon_codes to be redeemed on the subscription during the change. Only allowed if timeframe is now and you change something about the subscription that creates an invoice.
      define_attribute :coupon_codes, Array, { :item_type => String }

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. If an invoice's net terms are set to '0', it is due 'On Receipt' and will become past due 24 hours after it’s created. If an invoice is due net 30, it will become past due at 31 days exactly.
      define_attribute :net_terms, Integer

      # @!attribute plan_code
      #   @return [String] If you want to change to a new plan, you can provide the plan's code or id. If both are provided the `plan_id` will be used.
      define_attribute :plan_code, String

      # @!attribute plan_id
      #   @return [String] If you want to change to a new plan, you can provide the plan's code or id. If both are provided the `plan_id` will be used.
      define_attribute :plan_id, String

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity of 1.
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute shipping
      #   @return [SubscriptionChangeShippingCreate] The shipping address can currently only be changed immediately, using SubscriptionUpdate.
      define_attribute :shipping, :SubscriptionChangeShippingCreate

      # @!attribute timeframe
      #   @return [String] The timeframe parameter controls when the upgrade or downgrade takes place. The subscription change can occur now, when the subscription is next billed, or when the subscription term ends. Generally, if you're performing an upgrade, you will want the change to occur immediately (now). If you're performing a downgrade, you should set the timeframe to `term_end` or `bill_date` so the change takes effect at a scheduled billing date. The `renewal` timeframe option is accepted as an alias for `term_end`.
      define_attribute :timeframe, String

      # @!attribute transaction_type
      #   @return [String] An optional type designation for the payment gateway transaction created by this request. Supports 'moto' value, which is the acronym for mail order and telephone transactions.
      define_attribute :transaction_type, String

      # @!attribute unit_amount
      #   @return [Float] Optionally, sets custom pricing for the subscription, overriding the plan's default unit amount. The subscription's current currency will be used.
      define_attribute :unit_amount, Float
    end
  end
end

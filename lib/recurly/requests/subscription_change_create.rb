# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionChangeCreate < Request

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOnCreate]] If you set this value you include all the add-ons and their quantities and amounts. The values you include will replace the previous values entirely.
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOnCreate }

      # @!attribute collection_method
      #   @return [String] Collection method
      define_attribute :collection_method, String

      # @!attribute coupon_codes
      #   @return [Array[String]] A list of coupon_codes to be redeemed on the subscription during the change. Only allowed if timeframe is now and you change something about the subscription that creates an invoice.
      define_attribute :coupon_codes, Array, { :item_type => String }

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

      # @!attribute timeframe
      #   @return [String] The timeframe parameter controls when the upgrade or downgrade takes place. The subscription change can occur now or when the subscription renews. Generally, if you're performing an upgrade, you will want the change to occur immediately (now). If you're performing a downgrade, you should set the timeframe to "renewal" so the change takes affect at the end of the current billing cycle.
      define_attribute :timeframe, String

      # @!attribute unit_amount
      #   @return [Float] Optionally, sets custom pricing for the subscription, overriding the plan's default unit amount. The subscription's current currency will be used.
      define_attribute :unit_amount, Float
    end
  end
end

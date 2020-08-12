# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionAddOn < Resource

      # @!attribute add_on
      #   @return [AddOnMini] Just the important parts.
      define_attribute :add_on, :AddOnMini

      # @!attribute add_on_source
      #   @return [String] Used to determine where the associated add-on data is pulled from. If this value is set to `plan_add_on` or left blank, then add-on data will be pulled from the plan's add-ons. If the associated `plan` has `allow_any_item_on_subscriptions` set to `true` and this field is set to `item`, then the associated add-on data will be pulled from the site's item catalog.
      define_attribute :add_on_source, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute expired_at
      #   @return [DateTime] Expired at
      define_attribute :expired_at, DateTime

      # @!attribute id
      #   @return [String] Subscription Add-on ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute quantity
      #   @return [Integer] Add-on quantity
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute subscription_id
      #   @return [String] Subscription ID
      define_attribute :subscription_id, String

      # @!attribute tier_type
      #   @return [String] The pricing model for the add-on.  For more information, [click here](https://docs.recurly.com/docs/billing-models#section-quantity-based).
      define_attribute :tier_type, String

      # @!attribute tiers
      #   @return [Array[SubscriptionAddOnTier]] Empty unless `tier_type` is `tiered`, `volume`, or `stairstep`.
      define_attribute :tiers, Array, { :item_type => :SubscriptionAddOnTier }

      # @!attribute unit_amount
      #   @return [Float] This is priced in the subscription's currency.
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime
    end
  end
end

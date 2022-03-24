# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionAddOnUpdate < Request

      # @!attribute add_on_source
      #   @return [String] Used to determine where the associated add-on data is pulled from. If this value is set to `plan_add_on` or left blank, then add-on data will be pulled from the plan's add-ons. If the associated `plan` has `allow_any_item_on_subscriptions` set to `true` and this field is set to `item`, then the associated add-on data will be pulled from the site's item catalog.
      define_attribute :add_on_source, String

      # @!attribute code
      #   @return [String] If a code is provided without an id, the subscription add-on attributes will be set to the current value for those attributes on the plan add-on unless provided in the request. If `add_on_source` is set to `plan_add_on` or left blank, then plan's add-on `code` should be used. If `add_on_source` is set to `item`, then the `code` from the associated item should be used.
      define_attribute :code, String

      # @!attribute id
      #   @return [String] When an id is provided, the existing subscription add-on attributes will persist unless overridden in the request.
      define_attribute :id, String

      # @!attribute percentage_tiers
      #   @return [Array[SubscriptionAddOnPercentageTier]] If percentage tiers are provided in the request, all existing percentage tiers on the Subscription Add-on will be removed and replaced by the percentage tiers in the request. Use only if add_on.tier_type is tiered or volume and add_on.usage_type is percentage. There must be one tier without an `ending_amount` value which represents the final tier.
      define_attribute :percentage_tiers, Array, { :item_type => :SubscriptionAddOnPercentageTier }

      # @!attribute quantity
      #   @return [Integer] Quantity
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute tiers
      #   @return [Array[SubscriptionAddOnTier]] If the plan add-on's `tier_type` is `flat`, then `tiers` must be absent. The `tiers` object must include one to many tiers with `ending_quantity` and `unit_amount`. There must be one tier without an `ending_quantity` value which represents the final tier.
      define_attribute :tiers, Array, { :item_type => :SubscriptionAddOnTier }

      # @!attribute unit_amount
      #   @return [Float] Allows up to 2 decimal places. Optionally, override the add-on's default unit amount. If the plan add-on's `tier_type` is `tiered`, `volume`, or `stairstep`, then `unit_amount` cannot be provided.
      define_attribute :unit_amount, Float

      # @!attribute unit_amount_decimal
      #   @return [String] Allows up to 9 decimal places. Optionally, override the add-on's default unit amount. If the plan add-on's `tier_type` is `tiered`, `volume`, or `stairstep`, then `unit_amount_decimal` cannot be provided. Only supported when the plan add-on's `add_on_type` = `usage`. If `unit_amount_decimal` is provided, `unit_amount` cannot be provided.
      define_attribute :unit_amount_decimal, String

      # @!attribute usage_percentage
      #   @return [Float] The percentage taken of the monetary amount of usage tracked. This can be up to 4 decimal places. A value between 0.0 and 100.0. Required if add_on_type is usage and usage_type is percentage.
      define_attribute :usage_percentage, Float
    end
  end
end

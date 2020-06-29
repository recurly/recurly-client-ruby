# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionAddOnUpdate < Request

      # @!attribute code
      #   @return [String] If a code is provided without an id, the subscription add-on attributes will be set to the current value for those attributes on the plan add-on unless provided in the request.
      define_attribute :code, String

      # @!attribute id
      #   @return [String] When an id is provided, the existing subscription add-on attributes will persist unless overridden in the request.
      define_attribute :id, String

      # @!attribute quantity
      #   @return [Integer] Quantity
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute tiers
      #   @return [Array[SubscriptionAddOnTier]] If the plan add-on's `tier_type` is `flat`, then `tiers` must be absent. The `tiers` object must include one to many tiers with `ending_quantity` and `unit_amount`. There must be one tier with an `ending_quantity` of 999999999 which is the default if not provided.
      define_attribute :tiers, Array, { :item_type => :SubscriptionAddOnTier }

      # @!attribute unit_amount
      #   @return [Float] Optionally, override the add-on's default unit amount.
      define_attribute :unit_amount, Float
    end
  end
end

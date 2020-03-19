# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionChange < Resource

      # @!attribute activate_at
      #   @return [DateTime] Activated at
      define_attribute :activate_at, DateTime

      # @!attribute activated
      #   @return [Boolean] Returns `true` if the subscription change is activated.
      define_attribute :activated, :Boolean

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOn]] These add-ons will be used when the subscription renews.
      define_attribute :add_ons, Array, { :item_type => :SubscriptionAddOn }

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime

      # @!attribute id
      #   @return [String] The ID of the Subscription Change.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute plan
      #   @return [PlanMini] Just the important parts.
      define_attribute :plan, :PlanMini

      # @!attribute quantity
      #   @return [Integer] Subscription quantity
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute setup_fee_revenue_schedule_type
      #   @return [String] Setup fee revenue schedule type
      define_attribute :setup_fee_revenue_schedule_type, String

      # @!attribute shipping
      #   @return [SubscriptionShipping] Subscription shipping details
      define_attribute :shipping, :SubscriptionShipping

      # @!attribute subscription_id
      #   @return [String] The ID of the subscription that is going to be changed.
      define_attribute :subscription_id, String

      # @!attribute unit_amount
      #   @return [Float] Unit amount
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime
    end
  end
end

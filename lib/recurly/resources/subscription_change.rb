module Recurly
  module Resources
    class SubscriptionChange < Resource

      # @!attribute [r] activate_at
      #   @return [DateTime] Activated at
      define_attribute :activate_at, DateTime, {:read_only => true}

      # @!attribute activated
      #   @return [Boolean] Returns `true` if the subscription change is activated.
      define_attribute :activated, :Boolean

      # @!attribute add_ons
      #   @return [Array[SubscriptionAddOn]] These add-ons will be used when the subscription renews.
      define_attribute :add_ons, Array, {:item_type => :SubscriptionAddOn}

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, {:read_only => true}

      # @!attribute [r] deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime, {:read_only => true}

      # @!attribute id
      #   @return [String] The ID of the Subscription Change.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute plan
      #   @return [Plan]
      define_attribute :plan, :Plan

      # @!attribute quantity
      #   @return [Integer] Subscription quantity
      define_attribute :quantity, Integer

      # @!attribute subscription_id
      #   @return [String] The ID of the subscription that is going to be changed.
      define_attribute :subscription_id, String

      # @!attribute unit_amount
      #   @return [Float] Unit amount
      define_attribute :unit_amount, Float

      # @!attribute [r] updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime, {:read_only => true}
    end
  end
end

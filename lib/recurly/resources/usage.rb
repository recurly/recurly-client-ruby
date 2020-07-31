# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Usage < Resource

      # @!attribute amount
      #   @return [Float] The amount of usage. Can be positive, negative, or 0. No decimals allowed, we will strip them. If the usage-based add-on is billed with a percentage, your usage will be a monetary amount you will want to format in cents. (e.g., $5.00 is "500").
      define_attribute :amount, Float

      # @!attribute billed_at
      #   @return [DateTime] When the usage record was billed on an invoice.
      define_attribute :billed_at, DateTime

      # @!attribute created_at
      #   @return [DateTime] When the usage record was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute id
      #   @return [String]
      define_attribute :id, String

      # @!attribute measured_unit_id
      #   @return [String] The ID of the measured unit associated with the add-on the usage record is for.
      define_attribute :measured_unit_id, String

      # @!attribute merchant_tag
      #   @return [String] Custom field for recording the id in your own system associated with the usage, so you can provide auditable usage displays to your customers using a GET on this endpoint.
      define_attribute :merchant_tag, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute recording_timestamp
      #   @return [DateTime] When the usage was recorded in your system.
      define_attribute :recording_timestamp, DateTime

      # @!attribute tier_type
      #   @return [String] The pricing model for the add-on.  For more information, [click here](https://docs.recurly.com/docs/billing-models#section-quantity-based).
      define_attribute :tier_type, String

      # @!attribute tiers
      #   @return [Array[SubscriptionAddOnTier]] The tiers and prices of the subscription based on the usage_timestamp. If tier_type = flat, tiers = null
      define_attribute :tiers, Array, { :item_type => :SubscriptionAddOnTier }

      # @!attribute updated_at
      #   @return [DateTime] When the usage record was billed on an invoice.
      define_attribute :updated_at, DateTime

      # @!attribute usage_timestamp
      #   @return [DateTime] When the usage actually happened. This will define the line item dates this usage is billed under and is important for revenue recognition.
      define_attribute :usage_timestamp, DateTime

      # @!attribute usage_type
      #   @return [String] Type of usage, returns usage type if `add_on_type` is `usage`.
      define_attribute :usage_type, String
    end
  end
end

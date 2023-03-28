# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalCharge < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute created_at
      #   @return [DateTime] When the external charge was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute description
      #   @return [String]
      define_attribute :description, String

      # @!attribute external_product_reference
      #   @return [ExternalProductReferenceMini] External Product Reference details
      define_attribute :external_product_reference, :ExternalProductReferenceMini

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external charge ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute quantity
      #   @return [Integer]
      define_attribute :quantity, Integer

      # @!attribute unit_amount
      #   @return [Float] Unit Amount
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] When the external charge was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

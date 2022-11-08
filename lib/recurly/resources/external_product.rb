# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalProduct < Resource

      # @!attribute created_at
      #   @return [DateTime] When the external product was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute external_product_references
      #   @return [Array[ExternalProductReferenceMini]] List of external product references of the external product.
      define_attribute :external_product_references, Array, { :item_type => :ExternalProductReferenceMini }

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external product ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Name to identify the external product in Recurly.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute plan
      #   @return [PlanMini] Just the important parts.
      define_attribute :plan, :PlanMini

      # @!attribute updated_at
      #   @return [DateTime] When the external product was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

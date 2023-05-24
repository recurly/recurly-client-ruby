# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalProductCreate < Request

      # @!attribute external_product_references
      #   @return [Array[ExternalProductReferenceBase]] List of external product references of the external product.
      define_attribute :external_product_references, Array, { :item_type => :ExternalProductReferenceBase }

      # @!attribute name
      #   @return [String] External product name.
      define_attribute :name, String

      # @!attribute plan_id
      #   @return [String] Recurly plan UUID.
      define_attribute :plan_id, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalChargeCreate < Request

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute description
      #   @return [String]
      define_attribute :description, String

      # @!attribute external_product_reference
      #   @return [ExternalProductReferenceCreate]
      define_attribute :external_product_reference, :ExternalProductReferenceCreate

      # @!attribute quantity
      #   @return [Integer]
      define_attribute :quantity, Integer

      # @!attribute unit_amount
      #   @return [String]
      define_attribute :unit_amount, String
    end
  end
end

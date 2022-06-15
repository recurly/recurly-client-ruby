# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AddOnPricing < Request

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute tax_inclusive
      #   @return [Boolean] This field is deprecated. Please do not use it.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute unit_amount
      #   @return [Float] Unit price
      define_attribute :unit_amount, Float
    end
  end
end

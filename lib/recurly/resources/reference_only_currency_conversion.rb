# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ReferenceOnlyCurrencyConversion < Resource

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute date
      #   @return [String] The date of the conversion rate.
      define_attribute :date, String

      # @!attribute rate
      #   @return [String] The conversion rate to the currency.
      define_attribute :rate, String

      # @!attribute source
      #   @return [String] The source of the conversion rate.
      define_attribute :source, String

      # @!attribute subtotal_in_cents
      #   @return [Float] The subtotal converted to the currency.
      define_attribute :subtotal_in_cents, Float

      # @!attribute tax_in_cents
      #   @return [Float] The tax converted to the currency.
      define_attribute :tax_in_cents, Float
    end
  end
end

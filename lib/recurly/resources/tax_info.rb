module Recurly
  module Resources
    class TaxInfo < Resource

      # @!attribute rate
      #   @return [Float] Rate
      define_attribute :rate, Float

      # @!attribute region
      #   @return [String] Provides the tax region applied on an invoice. For U.S. Sales Tax, this will be the 2 letter state code. For EU VAT this will be the 2 letter country code. For all country level tax types, this will display the regional tax, like VAT, GST, or PST.
      define_attribute :region, String

      # @!attribute type
      #   @return [String] Provides the tax type as "vat" for EU VAT, "usst" for U.S. Sales Tax, or the 2 letter country code for country level tax types like Canada, Australia, New Zealand, Israel, and all non-EU European countries.
      define_attribute :type, String
    end
  end
end

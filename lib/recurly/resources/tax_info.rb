# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TaxInfo < Resource
      
      # @!attribute rate
      #   @return [Float] Rate
      define_attribute :rate, Float
      
      # @!attribute region
      #   @return [String] Provides the tax region applied on an invoice. For U.S. Sales Tax, this will be the 2 letter state code. For EU VAT this will be the 2 letter country code. For all country level tax types, this will display the regional tax, like VAT, GST, or PST.
      define_attribute :region, String
      
      # @!attribute tax_details
      #   @return [Array[TaxDetail]] Provides additional tax details for Canadian Sales Tax when there is tax applied at both the country and province levels. This will only be populated for the Invoice response when fetching a single invoice and not for the InvoiceList or LineItem.
      define_attribute :tax_details, Array, {:item_type=>:TaxDetail}
      
      # @!attribute type
      #   @return [String] Provides the tax type as "vat" for EU VAT, "usst" for U.S. Sales Tax, or the 2 letter country code for country level tax types like Canada, Australia, New Zealand, Israel, and all non-EU European countries.
      define_attribute :type, String
      
    end
  end
end

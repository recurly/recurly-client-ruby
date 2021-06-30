# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TaxDetail < Resource

      # @!attribute rate
      #   @return [Float] Provides the tax rate for the region.
      define_attribute :rate, Float

      # @!attribute region
      #   @return [String] Provides the tax region applied on an invoice. For Canadian Sales Tax, this will be either the 2 letter province code or country code.
      define_attribute :region, String

      # @!attribute tax
      #   @return [Float] The total tax applied for this tax type.
      define_attribute :tax, Float

      # @!attribute type
      #   @return [String] Provides the tax type for the region. For Canadian Sales Tax, this will be GST, HST, QST or PST.
      define_attribute :type, String
    end
  end
end

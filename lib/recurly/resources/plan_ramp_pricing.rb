# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PlanRampPricing < Resource

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute price_segment_id
      #   @return [String] The price segment ID or code. For ID no prefix is used e.g. `e28zov4fw0v2`. For requests, the code can also be used. Use prefix `code-`, e.g. `code-gold`.
      define_attribute :price_segment_id, String

      # @!attribute unit_amount
      #   @return [Float] Represents the price for the Ramp Interval.
      define_attribute :unit_amount, Float
    end
  end
end

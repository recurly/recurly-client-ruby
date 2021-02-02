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

      # @!attribute unit_amount
      #   @return [Float] The unit amount to use as the price per unit. Allows up to 2 decimal places. It is required unless `add_on_type` = `usage` and `usage_type` = `price` and `unit_amount_decimal` is provided. If `unit_amount_decimal` is provided, `unit_amount` cannot be provided.
      define_attribute :unit_amount, Float
    end
  end
end

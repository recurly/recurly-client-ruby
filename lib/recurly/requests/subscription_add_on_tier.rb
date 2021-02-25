# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionAddOnTier < Request

      # @!attribute ending_quantity
      #   @return [Integer] Ending quantity
      define_attribute :ending_quantity, Integer

      # @!attribute unit_amount
      #   @return [Float] Allows up to 2 decimal places. Optionally, override the tiers' default unit amount.
      define_attribute :unit_amount, Float

      # @!attribute unit_amount_decimal
      #   @return [String] Allows up to 9 decimal places.  Optionally, override tiers' default unit amount. If `unit_amount_decimal` is provided, `unit_amount` cannot be provided.
      define_attribute :unit_amount_decimal, String
    end
  end
end

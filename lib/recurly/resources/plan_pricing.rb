# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PlanPricing < Resource

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute price_segment_id
      #   @return [String] The price segment ID or code. For ID no prefix is used e.g. `e28zov4fw0v2`. For requests, the code can also be used. Use prefix `code-`, e.g. `code-gold`.
      define_attribute :price_segment_id, String

      # @!attribute setup_fee
      #   @return [Float] This field is deprecated, please use top level `setup_fees` instead. Amount of one-time setup fee automatically charged at the beginning of a subscription billing cycle. For subscription plans with a trial, the setup fee will be charged at the time of signup. Setup fees do not increase with the quantity of a subscription plan.
      define_attribute :setup_fee, Float

      # @!attribute tax_inclusive
      #   @return [Boolean] This field is deprecated. Please do not use it.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute unit_amount
      #   @return [Float] This field should not be sent when the pricing model is `'ramp'`.
      define_attribute :unit_amount, Float
    end
  end
end

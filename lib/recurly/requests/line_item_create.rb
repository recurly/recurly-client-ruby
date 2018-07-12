module Recurly
  module Requests
    class LineItemCreate < Request

      # @!attribute credit_reason_code
      #   @return [String] The reason the credit was given when line item is `type=credit`. When the Credit Invoices feature is enabled, the value can be set and will default to `general`. When the Credit Invoices feature is not enabled, the value will always be `null`.
      define_attribute :credit_reason_code, String, {:enum=>["general", "service", "promotional"]}

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute description
      #   @return [String] Description that appears on the invoice.
      define_attribute :description, String

      # @!attribute end_date
      #   @return [DateTime] If this date is provided, it indicates the end of a time range.
      define_attribute :end_date, DateTime

      # @!attribute quantity
      #   @return [Integer] This number will be multiplied by the unit amount to compute the subtotal before any discounts or taxes.
      define_attribute :quantity, Integer

      # @!attribute start_date
      #   @return [DateTime] If an end date is present, this is value indicates the beginning of a billing time range. If no end date is present it indicates billing for a specific date. Defaults to the current date-time.
      define_attribute :start_date, DateTime

      # @!attribute tax_code
      #   @return [String] Optional field for EU VAT merchants and Avalara AvaTax Pro merchants. If you are using Recurly's EU VAT feature, you can use values of unknown, physical, or digital. If you have your own AvaTax account configured, you can use Avalara tax codes to assign custom tax rules.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on charges, `false` applies tax on charges. If not defined, then defaults to the Plan and Site settings. This attribute does not work for credits (negative line items). Credits are always applied post-tax. Pre-tax discounts should use the Coupons feature.
      define_attribute :tax_exempt, :Boolean

      # @!attribute type
      #   @return [String] Line item type.
      define_attribute :type, String, {:enum=>["charge", "credit"]}

      # @!attribute unit_amount
      #   @return [Float] A positive or negative amount with `type=charge` will result in a positive `unit_amount`. A positive or negative amount with `type=credit` will result in a negative `unit_amount`.
      define_attribute :unit_amount, Float

    end
  end
end

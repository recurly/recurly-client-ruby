# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class LineItemCreate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting Code for the `LineItem`. If `item_code`/`item_id` is part of the request then `accounting_code` must be absent.
      define_attribute :accounting_code, String

      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the line item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types. If an `Item` is associated to the `LineItem`, then the `avalara_service_type` must be absent.
      define_attribute :avalara_service_type, Integer

      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the line item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types. If an `Item` is associated to the `LineItem`, then the `avalara_transaction_type` must be absent.
      define_attribute :avalara_transaction_type, Integer

      # @!attribute credit_reason_code
      #   @return [String] The reason the credit was given when line item is `type=credit`. When the Credit Invoices feature is enabled, the value can be set and will default to `general`. When the Credit Invoices feature is not enabled, the value will always be `null`.
      define_attribute :credit_reason_code, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code. If `item_code`/`item_id` is part of the request then `currency` is optional, if the site has a single default currency. `currency` is required if `item_code`/`item_id` is present, and there are multiple currencies defined on the site. If `item_code`/`item_id` is not present `currency` is required.
      define_attribute :currency, String

      # @!attribute description
      #   @return [String] Description that appears on the invoice. If `item_code`/`item_id` is part of the request then `description` must be absent.
      define_attribute :description, String

      # @!attribute end_date
      #   @return [DateTime] If this date is provided, it indicates the end of a time range.
      define_attribute :end_date, DateTime

      # @!attribute item_code
      #   @return [String] Unique code to identify an item. Available when the Credit Invoices and Subscription Billing Terms features are enabled.
      define_attribute :item_code, String

      # @!attribute item_id
      #   @return [String] System-generated unique identifier for an item. Available when the Credit Invoices and Subscription Billing Terms features are enabled.
      define_attribute :item_id, String

      # @!attribute origin
      #   @return [String] Origin `external_gift_card` is allowed if the Gift Cards feature is enabled on your site and `type` is `credit`. Set this value in order to track gift card credits from external gift cards (like InComm). It also skips billing information requirements.  Origin `prepayment` is only allowed if `type` is `charge` and `tax_exempt` is left blank or set to true.  This origin creates a charge and opposite credit on the account to be used for future invoices.
      define_attribute :origin, String

      # @!attribute product_code
      #   @return [String] Optional field to track a product code or SKU for the line item. This can be used to later reporting on product purchases. For Vertex tax calculations, this field will be used as the Vertex `product` field. If `item_code`/`item_id` is part of the request then `product_code` must be absent.
      define_attribute :product_code, String

      # @!attribute quantity
      #   @return [Integer] This number will be multiplied by the unit amount to compute the subtotal before any discounts or taxes.
      define_attribute :quantity, Integer

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute start_date
      #   @return [DateTime] If an end date is present, this is value indicates the beginning of a billing time range. If no end date is present it indicates billing for a specific date. Defaults to the current date-time.
      define_attribute :start_date, DateTime

      # @!attribute tax_code
      #   @return [String] Optional field used by Avalara, Vertex, and Recurly's EU VAT tax feature to determine taxation rules. If you have your own AvaTax or Vertex account configured, use their tax codes to assign specific tax rules. If you are using Recurly's EU VAT feature, you can use values of `unknown`, `physical`, or `digital`.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on charges, `false` applies tax on charges. If not defined, then defaults to the Plan and Site settings. This attribute does not work for credits (negative line items). Credits are always applied post-tax. Pre-tax discounts should use the Coupons feature.
      define_attribute :tax_exempt, :Boolean

      # @!attribute type
      #   @return [String] Line item type. If `item_code`/`item_id` is present then `type` should not be present. If `item_code`/`item_id` is not present then `type` is required.
      define_attribute :type, String

      # @!attribute unit_amount
      #   @return [Float] A positive or negative amount with `type=charge` will result in a positive `unit_amount`. A positive or negative amount with `type=credit` will result in a negative `unit_amount`. If `item_code`/`item_id` is present, `unit_amount` can be passed in, to override the `Item`'s `unit_amount`. If `item_code`/`item_id` is not present then `unit_amount` is required.
      define_attribute :unit_amount, Float
    end
  end
end

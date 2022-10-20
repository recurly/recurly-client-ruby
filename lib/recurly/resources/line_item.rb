# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class LineItem < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute accounting_code
      #   @return [String] Internal accounting code to help you reconcile your revenue to the correct ledger. Line items created as part of a subscription invoice will use the plan or add-on's accounting code, otherwise the value will only be present if you define an accounting code when creating the line item.
      define_attribute :accounting_code, String

      # @!attribute add_on_code
      #   @return [String] If the line item is a charge or credit for an add-on, this is its code.
      define_attribute :add_on_code, String

      # @!attribute add_on_id
      #   @return [String] If the line item is a charge or credit for an add-on this is its ID.
      define_attribute :add_on_id, String

      # @!attribute amount
      #   @return [Float] `(quantity * unit_amount) - (discount + tax)`
      define_attribute :amount, Float

      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the line item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_service_type, Integer

      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the line item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_transaction_type, Integer

      # @!attribute bill_for_account_id
      #   @return [String] The UUID of the account responsible for originating the line item.
      define_attribute :bill_for_account_id, String

      # @!attribute created_at
      #   @return [DateTime] When the line item was created.
      define_attribute :created_at, DateTime

      # @!attribute credit_applied
      #   @return [Float] The amount of credit from this line item that was applied to the invoice.
      define_attribute :credit_applied, Float

      # @!attribute credit_reason_code
      #   @return [String] The reason the credit was given when line item is `type=credit`.
      define_attribute :credit_reason_code, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute description
      #   @return [String] Description that appears on the invoice. For subscription related items this will be filled in automatically.
      define_attribute :description, String

      # @!attribute discount
      #   @return [Float] The discount applied to the line item.
      define_attribute :discount, Float

      # @!attribute end_date
      #   @return [DateTime] If this date is provided, it indicates the end of a time range.
      define_attribute :end_date, DateTime

      # @!attribute external_sku
      #   @return [String] Optional Stock Keeping Unit assigned to an item. Available when the Credit Invoices feature is enabled.
      define_attribute :external_sku, String

      # @!attribute id
      #   @return [String] Line item ID
      define_attribute :id, String

      # @!attribute invoice_id
      #   @return [String] Once the line item has been invoiced this will be the invoice's ID.
      define_attribute :invoice_id, String

      # @!attribute invoice_number
      #   @return [String] Once the line item has been invoiced this will be the invoice's number. If VAT taxation and the Country Invoice Sequencing feature are enabled, invoices will have country-specific invoice numbers for invoices billed to EU countries (ex: FR1001). Non-EU invoices will continue to use the site-level invoice number sequence.
      define_attribute :invoice_number, String

      # @!attribute item_code
      #   @return [String] Unique code to identify an item. Available when the Credit Invoices feature is enabled.
      define_attribute :item_code, String

      # @!attribute item_id
      #   @return [String] System-generated unique identifier for an item. Available when the Credit Invoices feature is enabled.
      define_attribute :item_id, String

      # @!attribute legacy_category
      #   @return [String] Category to describe the role of a line item on a legacy invoice: - "charges" refers to charges being billed for on this invoice. - "credits" refers to refund or proration credits. This portion of the invoice can be considered a credit memo. - "applied_credits" refers to previous credits applied to this invoice. See their original_line_item_id to determine where the credit first originated. - "carryforwards" can be ignored. They exist to consume any remaining credit balance. A new credit with the same amount will be created and placed back on the account.
      define_attribute :legacy_category, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute origin
      #   @return [String] A credit created from an original charge will have the value of the charge's origin.
      define_attribute :origin, String

      # @!attribute original_line_item_invoice_id
      #   @return [String] The invoice where the credit originated. Will only have a value if the line item is a credit created from a previous credit, or if the credit was created from a charge refund.
      define_attribute :original_line_item_invoice_id, String

      # @!attribute plan_code
      #   @return [String] If the line item is a charge or credit for a plan or add-on, this is the plan's code.
      define_attribute :plan_code, String

      # @!attribute plan_id
      #   @return [String] If the line item is a charge or credit for a plan or add-on, this is the plan's ID.
      define_attribute :plan_id, String

      # @!attribute previous_line_item_id
      #   @return [String] Will only have a value if the line item is a credit created from a previous credit, or if the credit was created from a charge refund.
      define_attribute :previous_line_item_id, String

      # @!attribute product_code
      #   @return [String] For plan-related line items this will be the plan's code, for add-on related line items it will be the add-on's code. For item-related line items it will be the item's `external_sku`.
      define_attribute :product_code, String

      # @!attribute proration_rate
      #   @return [Float] When a line item has been prorated, this is the rate of the proration. Proration rates were made available for line items created after March 30, 2017. For line items created prior to that date, the proration rate will be `null`, even if the line item was prorated.
      define_attribute :proration_rate, Float

      # @!attribute quantity
      #   @return [Integer] This number will be multiplied by the unit amount to compute the subtotal before any discounts or taxes.
      define_attribute :quantity, Integer

      # @!attribute quantity_decimal
      #   @return [String] A floating-point alternative to Quantity. If this value is present, it will be used in place of Quantity for calculations, and Quantity will be the rounded integer value of this number. This field supports up to 9 decimal places. The Decimal Quantity feature must be enabled to utilize this field.
      define_attribute :quantity_decimal, String

      # @!attribute refund
      #   @return [Boolean] Refund?
      define_attribute :refund, :Boolean

      # @!attribute refunded_quantity
      #   @return [Integer] For refund charges, the quantity being refunded. For non-refund charges, the total quantity refunded (possibly over multiple refunds).
      define_attribute :refunded_quantity, Integer

      # @!attribute refunded_quantity_decimal
      #   @return [String] A floating-point alternative to Refunded Quantity. For refund charges, the quantity being refunded. For non-refund charges, the total quantity refunded (possibly over multiple refunds). The Decimal Quantity feature must be enabled to utilize this field.
      define_attribute :refunded_quantity_decimal, String

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute shipping_address
      #   @return [ShippingAddress]
      define_attribute :shipping_address, :ShippingAddress

      # @!attribute start_date
      #   @return [DateTime] If an end date is present, this is value indicates the beginning of a billing time range. If no end date is present it indicates billing for a specific date.
      define_attribute :start_date, DateTime

      # @!attribute state
      #   @return [String] Pending line items are charges or credits on an account that have not been applied to an invoice yet. Invoiced line items will always have an `invoice_id` value.
      define_attribute :state, String

      # @!attribute subscription_id
      #   @return [String] If the line item is a charge or credit for a subscription, this is its ID.
      define_attribute :subscription_id, String

      # @!attribute subtotal
      #   @return [Float] `quantity * unit_amount`
      define_attribute :subtotal, Float

      # @!attribute tax
      #   @return [Float] The tax amount for the line item.
      define_attribute :tax, Float

      # @!attribute tax_code
      #   @return [String] Used by Avalara, Vertex, and Recurly’s EU VAT tax feature. The tax code values are specific to each tax system. If you are using Recurly’s EU VAT feature you can use `unknown`, `physical`, or `digital`.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on charges, `false` applies tax on charges. If not defined, then defaults to the Plan and Site settings. This attribute does not work for credits (negative line items). Credits are always applied post-tax. Pre-tax discounts should use the Coupons feature.
      define_attribute :tax_exempt, :Boolean

      # @!attribute tax_inclusive
      #   @return [Boolean] Determines whether or not tax is included in the unit amount. The Tax Inclusive Pricing feature (separate from the Mixed Tax Pricing feature) must be enabled to utilize this flag.
      define_attribute :tax_inclusive, :Boolean

      # @!attribute tax_info
      #   @return [TaxInfo] Tax info
      define_attribute :tax_info, :TaxInfo

      # @!attribute taxable
      #   @return [Boolean] `true` if the line item is taxable, `false` if it is not.
      define_attribute :taxable, :Boolean

      # @!attribute type
      #   @return [String] Charges are positive line items that debit the account. Credits are negative line items that credit the account.
      define_attribute :type, String

      # @!attribute unit_amount
      #   @return [Float] Positive amount for a charge, negative amount for a credit.
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] When the line item was last changed.
      define_attribute :updated_at, DateTime

      # @!attribute uuid
      #   @return [String] The UUID is useful for matching data with the CSV exports and building URLs into Recurly's UI.
      define_attribute :uuid, String
    end
  end
end

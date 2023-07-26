# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Invoice < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute address
      #   @return [InvoiceAddress]
      define_attribute :address, :InvoiceAddress

      # @!attribute balance
      #   @return [Float] The outstanding balance remaining on this invoice.
      define_attribute :balance, Float

      # @!attribute billing_info_id
      #   @return [String] The `billing_info_id` is the value that represents a specific billing info for an end customer. When `billing_info_id` is used to assign billing info to the subscription, all future billing events for the subscription will bill to the specified billing info. `billing_info_id` can ONLY be used for sites utilizing the Wallet feature.
      define_attribute :billing_info_id, String

      # @!attribute business_entity_id
      #   @return [String] Unique ID to identify the business entity assigned to the invoice. Available when the `Multiple Business Entities` feature is enabled.
      define_attribute :business_entity_id, String

      # @!attribute closed_at
      #   @return [DateTime] Date invoice was marked paid or failed.
      define_attribute :closed_at, DateTime

      # @!attribute collection_method
      #   @return [String] An automatic invoice means a corresponding transaction is run using the account's billing information at the same time the invoice is created. Manual invoices are created without a corresponding transaction. The merchant must enter a manual payment transaction or have the customer pay the invoice with an automatic method, like credit card, PayPal, Amazon, or ACH bank payment.
      define_attribute :collection_method, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute credit_payments
      #   @return [Array[CreditPayment]] Credit payments
      define_attribute :credit_payments, Array, { :item_type => :CreditPayment }

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute customer_notes
      #   @return [String] This will default to the Customer Notes text specified on the Invoice Settings. Specify custom notes to add or override Customer Notes.
      define_attribute :customer_notes, String

      # @!attribute discount
      #   @return [Float] Total discounts applied to this invoice.
      define_attribute :discount, Float

      # @!attribute due_at
      #   @return [DateTime] Date invoice is due. This is the date the net terms are reached.
      define_attribute :due_at, DateTime

      # @!attribute dunning_campaign_id
      #   @return [String] Unique ID to identify the dunning campaign used when dunning the invoice. For sites without multiple dunning campaigns enabled, this will always be the default dunning campaign.
      define_attribute :dunning_campaign_id, String

      # @!attribute dunning_events_sent
      #   @return [Integer] Number of times the event was sent.
      define_attribute :dunning_events_sent, Integer

      # @!attribute final_dunning_event
      #   @return [Boolean] Last communication attempt.
      define_attribute :final_dunning_event, :Boolean

      # @!attribute has_more_line_items
      #   @return [Boolean] Identifies if the invoice has more line items than are returned in `line_items`. If `has_more_line_items` is `true`, then a request needs to be made to the `list_invoice_line_items` endpoint.
      define_attribute :has_more_line_items, :Boolean

      # @!attribute id
      #   @return [String] Invoice ID
      define_attribute :id, String

      # @!attribute line_items
      #   @return [Array[LineItem]] Line Items
      define_attribute :line_items, Array, { :item_type => :LineItem }

      # @!attribute net_terms
      #   @return [Integer] Integer paired with `Net Terms Type` and representing the number of days past the current date (for `net` Net Terms Type) or days after the last day of the current month (for `eom` Net Terms Type) that the invoice will become past due. For any value, an additional 24 hours is added to ensure the customer has the entire last day to make payment before becoming past due.  For example:  If an invoice is due `net 0`, it is due 'On Receipt' and will become past due 24 hours after it's created. If an invoice is due `net 30`, it will become past due at 31 days exactly. If an invoice is due `eom 30`, it will become past due 31 days from the last day of the current month.  When `eom` Net Terms Type is passed, the value for `Net Terms` is restricted to `0, 15, 30, 45, 60, or 90`. For more information please visit our docs page (https://docs.recurly.com/docs/manual-payments#section-collection-terms)
      define_attribute :net_terms, Integer

      # @!attribute net_terms_type
      #   @return [String] Optionally supplied string that may be either `net` or `eom` (end-of-month). When `net`, an invoice becomes past due the specified number of `Net Terms` days from the current date. When `eom` an invoice becomes past due the specified number of `Net Terms` days from the last day of the current month.  This field is only available when the EOM Net Terms feature is enabled.
      define_attribute :net_terms_type, String

      # @!attribute number
      #   @return [String] If VAT taxation and the Country Invoice Sequencing feature are enabled, invoices will have country-specific invoice numbers for invoices billed to EU countries (ex: FR1001). Non-EU invoices will continue to use the site-level invoice number sequence.
      define_attribute :number, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute origin
      #   @return [String] The event that created the invoice.
      define_attribute :origin, String

      # @!attribute paid
      #   @return [Float] The total amount of successful payments transaction on this invoice.
      define_attribute :paid, Float

      # @!attribute po_number
      #   @return [String] For manual invoicing, this identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute previous_invoice_id
      #   @return [String] On refund invoices, this value will exist and show the invoice ID of the purchase invoice the refund was created from. This field is only populated for sites without the [Only Bill What Changed](https://docs.recurly.com/docs/only-bill-what-changed) feature enabled. Sites with Only Bill What Changed enabled should use the [related_invoices endpoint](https://recurly.com/developers/api/v2021-02-25/index.html#operation/list_related_invoices) to see purchase invoices refunded by this invoice.
      define_attribute :previous_invoice_id, String

      # @!attribute refundable_amount
      #   @return [Float] The refundable amount on a charge invoice. It will be null for all other invoices.
      define_attribute :refundable_amount, Float

      # @!attribute shipping_address
      #   @return [ShippingAddress]
      define_attribute :shipping_address, :ShippingAddress

      # @!attribute state
      #   @return [String] Invoice state
      define_attribute :state, String

      # @!attribute subscription_ids
      #   @return [Array[String]] If the invoice is charging or refunding for one or more subscriptions, these are their IDs.
      define_attribute :subscription_ids, Array, { :item_type => String }

      # @!attribute subtotal
      #   @return [Float] The summation of charges and credits, before discounts and taxes.
      define_attribute :subtotal, Float

      # @!attribute tax
      #   @return [Float] The total tax on this invoice.
      define_attribute :tax, Float

      # @!attribute tax_info
      #   @return [TaxInfo] Tax info
      define_attribute :tax_info, :TaxInfo

      # @!attribute terms_and_conditions
      #   @return [String] This will default to the Terms and Conditions text specified on the Invoice Settings page in your Recurly admin. Specify custom notes to add or override Terms and Conditions.
      define_attribute :terms_and_conditions, String

      # @!attribute total
      #   @return [Float] The final total on this invoice. The summation of invoice charges, discounts, credits, and tax.
      define_attribute :total, Float

      # @!attribute transactions
      #   @return [Array[Transaction]] Transactions
      define_attribute :transactions, Array, { :item_type => :Transaction }

      # @!attribute type
      #   @return [String] Invoices are either charge, credit, or legacy invoices.
      define_attribute :type, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime

      # @!attribute used_tax_service
      #   @return [Boolean] Will be `true` when the invoice had a successful response from the tax service and `false` when the invoice was not sent to tax service due to a lack of address or enabled jurisdiction or was processed without tax due to a non-blocking error returned from the tax service.
      define_attribute :used_tax_service, :Boolean

      # @!attribute uuid
      #   @return [String] Invoice UUID
      define_attribute :uuid, String

      # @!attribute vat_number
      #   @return [String] VAT registration number for the customer on this invoice. This will come from the VAT Number field in the Billing Info or the Account Info depending on your tax settings and the invoice collection method.
      define_attribute :vat_number, String

      # @!attribute vat_reverse_charge_notes
      #   @return [String] VAT Reverse Charge Notes only appear if you have EU VAT enabled or are using your own Avalara AvaTax account and the customer is in the EU, has a VAT number, and is in a different country than your own. This will default to the VAT Reverse Charge Notes text specified on the Tax Settings page in your Recurly admin, unless custom notes were created with the original subscription.
      define_attribute :vat_reverse_charge_notes, String
    end
  end
end

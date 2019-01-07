# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please file a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class InvoiceRefund < Request

      # @!attribute amount
      #   @return [Integer] The amount to be refunded. The amount will be split between the line items. If no amount is specified, it will default to refunding the total refundable amount on the invoice.
      define_attribute :amount, Integer

      # @!attribute credit_customer_notes
      #   @return [String] Used as the Customer Notes on the credit invoice.  This field can only be include when the Credit Invoices feature is enabled.
      define_attribute :credit_customer_notes, String

      # @!attribute external_refund
      #   @return [Hash] Indicates that the refund was settled outside of Recurly, and a manual transaction should be created to track it in Recurly.  Required when: - refunding a manually collected charge invoice, and `refund_method` is not `all_credit` - refunding a credit invoice that refunded manually collecting invoices - refunding a credit invoice for a partial amount  This field can only be included when the Credit Invoices feature is enabled.
      define_attribute :external_refund, Hash

      # @!attribute line_items
      #   @return [Array[LineItemRefund]] The line items to be refunded. This is required when `type=line_items`.
      define_attribute :line_items, Array, {:item_type => :LineItemRefund}

      # @!attribute refund_method
      #   @return [String] Indicates how the invoice should be refunded when both a credit and transaction are present on the invoice: - `transaction_first` – Refunds the transaction first, then any amount is issued as credit back to the account. Default value when Credit Invoices feature is enabled. - `credit_first` – Issues credit back to the account first, then refunds any remaining amount back to the transaction. Default value when Credit Invoices feature is not enabled. - `all_credit` – Issues credit to the account for the entire amount of the refund. Only available when the Credit Invoices feature is enabled. - `all_transaction` – Refunds the entire amount back to transactions, using transactions from previous invoices if necessary. Only available when the Credit Invoices feature is enabled.
      define_attribute :refund_method, String, {:enum => ["transaction_first", "credit_first", "all_credit", "all_transaction"]}

      # @!attribute type
      #   @return [String] The type of refund. Amount and line items cannot both be specified in the request.
      define_attribute :type, String, {:enum => ["amount", "line_items"]}
    end
  end
end

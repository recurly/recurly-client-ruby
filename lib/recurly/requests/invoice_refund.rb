# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
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
      #   @return [ExternalRefund]
      define_attribute :external_refund, :ExternalRefund

      # @!attribute line_items
      #   @return [Array[LineItemRefund]] The line items to be refunded. This is required when `type=line_items`.
      define_attribute :line_items, Array, { :item_type => :LineItemRefund }

      # @!attribute refund_method
      #   @return [String] Indicates how the invoice should be refunded when both a credit and transaction are present on the invoice: - `transaction_first` – Refunds the transaction first, then any amount is issued as credit back to the account. Default value when Credit Invoices feature is enabled. - `credit_first` – Issues credit back to the account first, then refunds any remaining amount back to the transaction. Default value when Credit Invoices feature is not enabled. - `all_credit` – Issues credit to the account for the entire amount of the refund. Only available when the Credit Invoices feature is enabled. - `all_transaction` – Refunds the entire amount back to transactions, using transactions from previous invoices if necessary. Only available when the Credit Invoices feature is enabled.
      define_attribute :refund_method, String

      # @!attribute type
      #   @return [String] The type of refund. Amount and line items cannot both be specified in the request.
      define_attribute :type, String
    end
  end
end

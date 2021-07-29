# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Transaction < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute amount
      #   @return [Float] Total transaction amount sent to the payment gateway.
      define_attribute :amount, Float

      # @!attribute avs_check
      #   @return [String] When processed, result from checking the overall AVS on the transaction.
      define_attribute :avs_check, String

      # @!attribute backup_payment_method_used
      #   @return [Boolean] Indicates if the transaction was completed using a backup payment
      define_attribute :backup_payment_method_used, :Boolean

      # @!attribute billing_address
      #   @return [AddressWithName]
      define_attribute :billing_address, :AddressWithName

      # @!attribute collected_at
      #   @return [DateTime] Collected at, or if not collected yet, the time the transaction was created.
      define_attribute :collected_at, DateTime

      # @!attribute collection_method
      #   @return [String] The method by which the payment was collected.
      define_attribute :collection_method, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute customer_message
      #   @return [String] For declined (`success=false`) transactions, the message displayed to the customer.
      define_attribute :customer_message, String

      # @!attribute customer_message_locale
      #   @return [String] Language code for the message
      define_attribute :customer_message_locale, String

      # @!attribute cvv_check
      #   @return [String] When processed, result from checking the CVV/CVC value on the transaction.
      define_attribute :cvv_check, String

      # @!attribute gateway_approval_code
      #   @return [String] Transaction approval code from the payment gateway.
      define_attribute :gateway_approval_code, String

      # @!attribute gateway_message
      #   @return [String] Transaction message from the payment gateway.
      define_attribute :gateway_message, String

      # @!attribute gateway_reference
      #   @return [String] Transaction reference number from the payment gateway.
      define_attribute :gateway_reference, String

      # @!attribute gateway_response_code
      #   @return [String] For declined transactions (`success=false`), this field lists the gateway error code.
      define_attribute :gateway_response_code, String

      # @!attribute gateway_response_time
      #   @return [Float] Time, in seconds, for gateway to process the transaction.
      define_attribute :gateway_response_time, Float

      # @!attribute gateway_response_values
      #   @return [Hash] The values in this field will vary from gateway to gateway.
      define_attribute :gateway_response_values, Hash

      # @!attribute id
      #   @return [String] Transaction ID
      define_attribute :id, String

      # @!attribute invoice
      #   @return [InvoiceMini] Invoice mini details
      define_attribute :invoice, :InvoiceMini

      # @!attribute ip_address_country
      #   @return [String] Origin IP address country, 2-letter ISO 3166-1 alpha-2 code, if known by Recurly.
      define_attribute :ip_address_country, String

      # @!attribute ip_address_v4
      #   @return [String] IP address provided when the billing information was collected:  - When the customer enters billing information into the Recurly.js or Hosted Payment Pages, Recurly records the IP address. - When the merchant enters billing information using the API, the merchant may provide an IP address. - When the merchant enters billing information using the UI, no IP address is recorded.
      define_attribute :ip_address_v4, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute origin
      #   @return [String] Describes how the transaction was triggered.
      define_attribute :origin, String

      # @!attribute original_transaction_id
      #   @return [String] If this transaction is a refund (`type=refund`), this will be the ID of the original transaction on the invoice being refunded.
      define_attribute :original_transaction_id, String

      # @!attribute payment_gateway
      #   @return [TransactionPaymentGateway]
      define_attribute :payment_gateway, :TransactionPaymentGateway

      # @!attribute payment_method
      #   @return [PaymentMethod]
      define_attribute :payment_method, :PaymentMethod

      # @!attribute refunded
      #   @return [Boolean] Indicates if part or all of this transaction was refunded.
      define_attribute :refunded, :Boolean

      # @!attribute status
      #   @return [String] The current transaction status. Note that the status may change, e.g. a `pending` transaction may become `declined` or `success` may later become `void`.
      define_attribute :status, String

      # @!attribute status_code
      #   @return [String] Status code
      define_attribute :status_code, String

      # @!attribute status_message
      #   @return [String] For declined (`success=false`) transactions, the message displayed to the merchant.
      define_attribute :status_message, String

      # @!attribute subscription_ids
      #   @return [Array[String]] If the transaction is charging or refunding for one or more subscriptions, these are their IDs.
      define_attribute :subscription_ids, Array, { :item_type => String }

      # @!attribute success
      #   @return [Boolean] Did this transaction complete successfully?
      define_attribute :success, :Boolean

      # @!attribute type
      #   @return [String] - `authorization` – verifies billing information and places a hold on money in the customer's account. - `capture` – captures funds held by an authorization and completes a purchase. - `purchase` – combines the authorization and capture in one transaction. - `refund` – returns all or a portion of the money collected in a previous transaction to the customer. - `verify` – a $0 or $1 transaction used to verify billing information which is immediately voided.
      define_attribute :type, String

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime

      # @!attribute uuid
      #   @return [String] The UUID is useful for matching data with the CSV exports and building URLs into Recurly's UI.
      define_attribute :uuid, String

      # @!attribute voided_at
      #   @return [DateTime] Voided at
      define_attribute :voided_at, DateTime

      # @!attribute voided_by_invoice
      #   @return [InvoiceMini] Invoice mini details
      define_attribute :voided_by_invoice, :InvoiceMini
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Transaction < Resource

      # @!attribute account
      #   @return [AccountMini]
      define_attribute :account, :AccountMini

      # @!attribute amount
      #   @return [Float] Total transaction amount sent to the payment gateway.
      define_attribute :amount, Float

      # @!attribute avs_check
      #   @return [String] When processed, result from checking the overall AVS on the transaction.
      define_attribute :avs_check, String, { :enum => ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }

      # @!attribute billing_address
      #   @return [Address]
      define_attribute :billing_address, :Address

      # @!attribute collected_at
      #   @return [DateTime] Collected at, or if not collected yet, the time the transaction was created.
      define_attribute :collected_at, DateTime

      # @!attribute collection_method
      #   @return [String] The method by which the payment was collected.
      define_attribute :collection_method, String, { :enum => ["automatic", "manual"] }

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
      define_attribute :cvv_check, String, { :enum => ["D", "I", "M", "N", "P", "S", "U", "X"] }

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
      #   @return [Integer] Time, in seconds, for gateway to process the transaction.
      define_attribute :gateway_response_time, Integer

      # @!attribute gateway_response_values
      #   @return [Hash] The values in this field will vary from gateway to gateway.
      define_attribute :gateway_response_values, Hash

      # @!attribute id
      #   @return [String] Transaction ID
      define_attribute :id, String

      # @!attribute invoice
      #   @return [InvoiceMini]
      define_attribute :invoice, :InvoiceMini

      # @!attribute ip_address_country
      #   @return [String] IP address's country
      define_attribute :ip_address_country, String

      # @!attribute ip_address_v4
      #   @return [String] IP address provided when the billing information was collected:  - When the customer enters billing information into the Recurly.JS or Hosted Payment Pages, Recurly records the IP address. - When the merchant enters billing information using the API, the merchant may provide an IP address. - When the merchant enters billing information using the UI, no IP address is recorded.
      define_attribute :ip_address_v4, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute origin
      #   @return [String] Describes how the transaction was triggered.
      define_attribute :origin, String, { :enum => ["api", "hpp", "merchant", "recurly_admin", "recurlyjs", "recurring", "transparent", "force_collect", "refunded_externally", "chargeback"] }

      # @!attribute original_transaction_id
      #   @return [String] If this transaction is a refund (`type=refund`), this will be the ID of the original transaction on the invoice being refunded.
      define_attribute :original_transaction_id, String

      # @!attribute payment_gateway
      #   @return [Hash]
      define_attribute :payment_gateway, Hash

      # @!attribute payment_method
      #   @return [Hash] Payment method (TODO: this overlaps with BillingInfo’s payment_method but only documents credit cards)
      define_attribute :payment_method, Hash

      # @!attribute refunded
      #   @return [Boolean] Indicates if part or all of this transaction was refunded.
      define_attribute :refunded, :Boolean

      # @!attribute status
      #   @return [String] The current transaction status. Note that the status may change, e.g. a `pending` transaction may become `declined` or `success` may later become `void`.
      define_attribute :status, String, { :enum => ["pending", "scheduled", "processing", "success", "void", "declined", "error", "chargeback"] }

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
      #   @return [String] Transaction type
      define_attribute :type, String, { :enum => ["authorization", "capture", "purchase", "refund", "verify"] }

      # @!attribute uuid
      #   @return [String] The UUID is useful for matching data with the CSV exports and building URLs into Recurly's UI.
      define_attribute :uuid, String

      # @!attribute voided_at
      #   @return [DateTime] Voided at
      define_attribute :voided_at, DateTime
    end
  end
end

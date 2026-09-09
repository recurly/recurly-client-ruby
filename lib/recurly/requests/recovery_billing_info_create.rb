# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryBillingInfoCreate < Request

      # @!attribute address
      #   @return [RecoveryAddress]
      define_attribute :address, :RecoveryAddress

      # @!attribute backup_payment_method
      #   @return [Boolean] The `backup_payment_method` field is used to designate a billing info as a backup on the account that will be tried if the initial billing info used for an invoice is declined. All payment methods, including the billing info marked `primary_payment_method` can be set as a backup. An account can have a maximum of 1 backup, if a user sets a different payment method as a backup, the existing backup will no longer be marked as such.
      define_attribute :backup_payment_method, :Boolean

      # @!attribute company
      #   @return [String] Company name
      define_attribute :company, String

      # @!attribute first_name
      #   @return [String] First name
      define_attribute :first_name, String

      # @!attribute gateway_code
      #   @return [String] An identifier for a specific payment gateway.
      define_attribute :gateway_code, String

      # @!attribute ip_address
      #   @return [String] *STRONGLY RECOMMENDED* Customer's IP address when updating their billing information.
      define_attribute :ip_address, String

      # @!attribute last_name
      #   @return [String] Last name
      define_attribute :last_name, String

      # @!attribute network_transaction_id
      #   @return [String] Network transaction ID from the previous customer-in-session subscription signup or billing info storage.  - 10-15 alphanumeric characters for Mastercard - 14-15 alphanumeric for Visa - 15 digits for all other brands - 16 alphanumeric characters for Cartes Bancaires, which are processed as Visa or Mastercard
      define_attribute :network_transaction_id, String

      # @!attribute payment_gateway_references
      #   @return [Array[PaymentGatewayReferences]] Array of Payment Gateway References, each a reference to a third-party gateway object of varying types.
      define_attribute :payment_gateway_references, Array, { :item_type => :PaymentGatewayReferences }

      # @!attribute payment_method
      #   @return [RecoveryPaymentMethodCreate] Merchant-supplied fallback payment method metadata. Recurly's own gateway-token lookup is authoritative and will override any of these fields it can determine itself; these fields are only used to fill gaps when that lookup is unavailable.
      define_attribute :payment_method, :RecoveryPaymentMethodCreate

      # @!attribute primary_payment_method
      #   @return [Boolean] The `primary_payment_method` field is used to designate the primary billing info on the account. An account can have a maximum of 1 primary. If a user sets a different payment method as a primary, then the existing primary will no longer be marked as such.
      define_attribute :primary_payment_method, :Boolean

      # @!attribute transactions
      #   @return [Array[RecoveryTransactionCreate]] Transactions from previous collection attempts for this payment method. Optional, unless this billing_info is the primary payment method and the account's dunning campaign skips Recurly's own retry attempts entirely -- in that case at least one entry is required.
      define_attribute :transactions, Array, { :item_type => :RecoveryTransactionCreate }
    end
  end
end

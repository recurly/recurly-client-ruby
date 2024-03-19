# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class BillingInfoCreate < Request

      # @!attribute account_number
      #   @return [String] The bank account number. (ACH, Bacs only)
      define_attribute :account_number, String

      # @!attribute account_type
      #   @return [String] The bank account type. (ACH only)
      define_attribute :account_type, String

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute amazon_billing_agreement_id
      #   @return [String] Amazon billing agreement ID
      define_attribute :amazon_billing_agreement_id, String

      # @!attribute backup_payment_method
      #   @return [Boolean] The `backup_payment_method` field is used to designate a billing info as a backup on the account that will be tried if the initial billing info used for an invoice is declined. All payment methods, including the billing info marked `primary_payment_method` can be set as a backup. An account can have a maximum of 1 backup, if a user sets a different payment method as a backup, the existing backup will no longer be marked as such.
      define_attribute :backup_payment_method, :Boolean

      # @!attribute card_network_preference
      #   @return [String] Represents the card network preference associated with the billing info for dual badged cards. Must be a supported card network.
      define_attribute :card_network_preference, String

      # @!attribute card_type
      #   @return [String]
      define_attribute :card_type, String

      # @!attribute company
      #   @return [String] Company name
      define_attribute :company, String

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute cvv
      #   @return [String] *STRONGLY RECOMMENDED*
      define_attribute :cvv, String

      # @!attribute external_hpp_type
      #   @return [String] Use for Adyen HPP billing info. This should only be used as part of a pending purchase request, when the billing info is nested inside an account object.
      define_attribute :external_hpp_type, String

      # @!attribute first_name
      #   @return [String] First name
      define_attribute :first_name, String

      # @!attribute fraud_session_id
      #   @return [String] Fraud Session ID
      define_attribute :fraud_session_id, String

      # @!attribute gateway_attributes
      #   @return [GatewayAttributes] Additional attributes to send to the gateway.
      define_attribute :gateway_attributes, :GatewayAttributes

      # @!attribute gateway_code
      #   @return [String] An identifier for a specific payment gateway. Must be used in conjunction with `gateway_token`.
      define_attribute :gateway_code, String

      # @!attribute gateway_token
      #   @return [String] A token used in place of a credit card in order to perform transactions. Must be used in conjunction with `gateway_code`.
      define_attribute :gateway_token, String

      # @!attribute iban
      #   @return [String] The International Bank Account Number, up to 34 alphanumeric characters comprising a country code; two check digits; and a number that includes the domestic bank account number, branch identifier, and potential routing information
      define_attribute :iban, String

      # @!attribute ip_address
      #   @return [String] *STRONGLY RECOMMENDED* Customer's IP address when updating their billing information.
      define_attribute :ip_address, String

      # @!attribute last_name
      #   @return [String] Last name
      define_attribute :last_name, String

      # @!attribute month
      #   @return [String] Expiration month
      define_attribute :month, String

      # @!attribute name_on_account
      #   @return [String] The name associated with the bank account (ACH, SEPA, Bacs only)
      define_attribute :name_on_account, String

      # @!attribute number
      #   @return [String] Credit card number, spaces and dashes are accepted.
      define_attribute :number, String

      # @!attribute online_banking_payment_type
      #   @return [String] Use for Online Banking billing info. This should only be used as part of a pending purchase request, when the billing info is nested inside an account object.
      define_attribute :online_banking_payment_type, String

      # @!attribute paypal_billing_agreement_id
      #   @return [String] PayPal billing agreement ID
      define_attribute :paypal_billing_agreement_id, String

      # @!attribute primary_payment_method
      #   @return [Boolean] The `primary_payment_method` field is used to designate the primary billing info on the account. The first billing info created on an account will always become primary. Adding additional billing infos provides the flexibility to mark another billing info as primary, or adding additional non-primary billing infos. This can be accomplished by passing the `primary_payment_method` with a value of `true`. When adding billing infos via the billing_info and /accounts endpoints, this value is not permitted, and will return an error if provided.
      define_attribute :primary_payment_method, :Boolean

      # @!attribute roku_billing_agreement_id
      #   @return [String] Roku's CIB if billing through Roku
      define_attribute :roku_billing_agreement_id, String

      # @!attribute routing_number
      #   @return [String] The bank's rounting number. (ACH only)
      define_attribute :routing_number, String

      # @!attribute sort_code
      #   @return [String] Bank identifier code for UK based banks. Required for Bacs based billing infos. (Bacs only)
      define_attribute :sort_code, String

      # @!attribute tax_identifier
      #   @return [String] Tax identifier is required if adding a billing info that is a consumer card in Brazil or in Argentina. This would be the customer's CPF/CNPJ (Brazil) and CUIT (Argentina). CPF, CNPJ and CUIT are tax identifiers for all residents who pay taxes in Brazil and Argentina respectively.
      define_attribute :tax_identifier, String

      # @!attribute tax_identifier_type
      #   @return [String] This field and a value of `cpf`, `cnpj` or `cuit` are required if adding a billing info that is an elo or hipercard type in Brazil or in Argentina.
      define_attribute :tax_identifier_type, String

      # @!attribute three_d_secure_action_result_token_id
      #   @return [String] A token generated by Recurly.js after completing a 3-D Secure device fingerprinting or authentication challenge.
      define_attribute :three_d_secure_action_result_token_id, String

      # @!attribute token_id
      #   @return [String] A token [generated by Recurly.js](https://recurly.com/developers/reference/recurly-js/#getting-a-token).
      define_attribute :token_id, String

      # @!attribute transaction_type
      #   @return [String] An optional type designation for the payment gateway transaction created by this request. Supports 'moto' value, which is the acronym for mail order and telephone transactions.
      define_attribute :transaction_type, String

      # @!attribute type
      #   @return [String] The payment method type for a non-credit card based billing info. `bacs` and `becs` are the only accepted values.
      define_attribute :type, String

      # @!attribute vat_number
      #   @return [String] VAT number
      define_attribute :vat_number, String

      # @!attribute year
      #   @return [String] Expiration year
      define_attribute :year, String
    end
  end
end

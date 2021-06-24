module Recurly
  # Represents an account's Billing Information. You normally want to use a token when creating billing information.
  #
  # Recurly Documentation: https://dev.recurly.com/docs/create-an-accounts-billing-info-token
  class BillingInfo < Resource
    BANK_ACCOUNT_ATTRIBUTES = %w(name_on_account account_type last_four routing_number).freeze
    CREDIT_CARD_ATTRIBUTES = %w(number verification_value card_type year month first_six last_four).freeze
    AMAZON_ATTRIBUTES = %w(amazon_billing_agreement_id amazon_region).freeze
    PAYPAL_ATTRIBUTES = %w(paypal_billing_agreement_id).freeze
    ROKU_ATTRIBUTES = %w(roku_billing_agreement_id last_four).freeze
    SEPA_ATTRIBUTES = %w(iban last_two).freeze
    BACS_ATTRIBUTES = %w(account_number sort_code type).freeze
    BECS_ATTRIBUTES = %w(account_number bsb_code type).freeze

    # @return [Account]
    belongs_to :account

    define_attribute_methods %w(
      uuid
      first_name
      last_name
      company
      address1
      address2
      city
      state
      zip
      country
      phone
      vat_number
      ip_address
      ip_address_country
      token_id
      currency
      geo_code
      updated_at
      external_hpp_type
      gateway_token
      gateway_code
      fraud_session_id
      three_d_secure_action_result_token_id
      transaction_type
      mandate_reference
      tax_identifier
      tax_identifier_type
      primary_payment_method
      backup_payment_method
      cc_bin_country
    ) | CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES | AMAZON_ATTRIBUTES | PAYPAL_ATTRIBUTES | ROKU_ATTRIBUTES | SEPA_ATTRIBUTES | BACS_ATTRIBUTES | BECS_ATTRIBUTES

    # Verify an account's stored billing info
    #
    # @param [Hash] gateway_code (optional) is the code for the gateway to use for verification. If unspecified, a gateway will be selected using the normal rules.
    # @return [Transaction]
    # @raise [Invalid] Raise if the account's billing info cannot be verified
    def verify(attrs = {})
      Transaction.from_response API.post("#{path}/verify", attrs.empty? ? nil : Verify.to_xml(attrs))
    end

    # @return [String]
    def inspect
      attributes = self.class.attribute_names
      case type
      when 'credit_card'
        attributes -= (AMAZON_ATTRIBUTES + PAYPAL_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
        attributes |= CREDIT_CARD_ATTRIBUTES
      when 'paypal'
        attributes -= (CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES + AMAZON_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
      when 'amazon'
        attributes -= (CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES + PAYPAL_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
      when 'bank_account'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
        attributes |= BANK_ACCOUNT_ATTRIBUTES
      when 'roku'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
        attributes |= ROKU_ATTRIBUTES
      when 'sepa'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES + ROKU_ATTRIBUTES + BACS_ATTRIBUTES + BECS_ATTRIBUTES)
        attributes |= SEPA_ATTRIBUTES
      when 'bacs'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BECS_ATTRIBUTES)
        attributes |= BACS_ATTRIBUTES
      when 'becs'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES + ROKU_ATTRIBUTES + SEPA_ATTRIBUTES + BACS_ATTRIBUTES)
        attributes |= BECS_ATTRIBUTES
      end
      super attributes
    end

    # @return ["credit_card", "paypal", "amazon", "bank_account", "roku", "sepa", "bacs", "becs", nil] The type of billing info.
    def type
      self[:type] || @type
    end

    class << self
      # Overrides the inherited member_path method to allow for billing info's
      # irregular URL structure.
      #
      # @return [String] The relative path to an account's billing info from the
      #   API's base URI.
      # @param uuid [String]
      # @example
      #   Recurly::BillingInfo.member_path "code"
      #   # => "accounts/code/billing_info"
      def member_path uuid
        "accounts/#{uuid}/billing_info"
      end
    end

    # Billing info is only writeable through an {Account} instance.
    embedded!
  end
end

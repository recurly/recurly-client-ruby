module Recurly
  class BillingInfo < Resource
    BANK_ACCOUNT_ATTRIBUTES = %w(name_on_account account_type last_four routing_number).freeze
    CREDIT_CARD_ATTRIBUTES = %w(number verification_value card_type year month first_six last_four).freeze
    AMAZON_ATTRIBUTES = %w(amazon_billing_agreement_id).freeze
    PAYPAL_ATTRIBUTES = %w(paypal_billing_agreement_id).freeze

    # @return [Account]
    belongs_to :account

    define_attribute_methods %w(
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
    ) | CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES | AMAZON_ATTRIBUTES | PAYPAL_ATTRIBUTES

    # @return ["credit_card", "paypal", "amazon", "bank_account", nil] The type of billing info.
    attr_reader :type

    # @return [String]
    def inspect
      attributes = self.class.attribute_names
      case type
      when 'credit_card'
        attributes -= (AMAZON_ATTRIBUTES + PAYPAL_ATTRIBUTES + BANK_ACCOUNT_ATTRIBUTES)
        attributes |= CREDIT_CARD_ATTRIBUTES
      when 'paypal'
        attributes -= (CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES + AMAZON_ATTRIBUTES)
      when 'amazon'
        attributes -= (CREDIT_CARD_ATTRIBUTES | BANK_ACCOUNT_ATTRIBUTES + PAYPAL_ATTRIBUTES)
      when 'bank_account'
        attributes -= (CREDIT_CARD_ATTRIBUTES + PAYPAL_ATTRIBUTES + AMAZON_ATTRIBUTES)
        attributes |= BANK_ACCOUNT_ATTRIBUTES
      end
      super attributes
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

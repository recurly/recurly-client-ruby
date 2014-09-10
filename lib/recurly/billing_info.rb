module Recurly
  class BillingInfo < Resource
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
      card_type
      year
      month
      start_year
      start_month
      issue_number
      first_six
      last_four
      paypal_billing_agreement_id
      amazon_billing_agreement_id
      number
      verification_value
      token_id
    )

    # @return ["credit_card", "paypal", "amazon", nil] The type of billing info.
    attr_reader :type

    # @return [String]
    def inspect
      attributes = self.class.attribute_names
      case type
      when 'credit_card'
        attributes -= %w(paypal_billing_agreement_id amazon_billing_agreement_id)
      when 'paypal'
        attributes -= %w(
          card_type year month start_year start_month issue_number
          first_six last_four
        )
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

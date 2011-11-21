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
      number
      verification_value
    )

    # @return ["credit_card", "paypal", nil] The type of billing info.
    attr_reader :type

    # @return [String]
    def inspect
      attributes = self.class.attribute_names
      case type
      when 'credit_card'
        attributes -= %w(paypal_billing_agreement_id)
      when 'paypal'
        attributes -= %w(
          card_type year month start_year start_month issue_number
          first_six last_four
        )
      end
      super attributes
    end

    # Billing info is only writeable through an {Account} instance.
    embedded!
  end
end

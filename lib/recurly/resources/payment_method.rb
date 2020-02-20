# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PaymentMethod < Resource

      # @!attribute account_type
      #   @return [String] The bank account type. Only present for ACH payment methods.
      define_attribute :account_type, String

      # @!attribute billing_agreement_id
      #   @return [String] Billing Agreement identifier. Only present for Amazon or Paypal payment methods.
      define_attribute :billing_agreement_id, String

      # @!attribute card_type
      #   @return [String] Visa, MasterCard, American Express, Discover, JCB, etc.
      define_attribute :card_type, String

      # @!attribute exp_month
      #   @return [Integer] Expiration month.
      define_attribute :exp_month, Integer

      # @!attribute exp_year
      #   @return [Integer] Expiration year.
      define_attribute :exp_year, Integer

      # @!attribute first_six
      #   @return [String] Credit card number's first six digits.
      define_attribute :first_six, String

      # @!attribute gateway_code
      #   @return [String] An identifier for a specific payment gateway.
      define_attribute :gateway_code, String

      # @!attribute gateway_token
      #   @return [String] A token used in place of a credit card in order to perform transactions.
      define_attribute :gateway_token, String

      # @!attribute last_four
      #   @return [String] Credit card number's last four digits. Will refer to bank account if payment method is ACH.
      define_attribute :last_four, String

      # @!attribute last_two
      #   @return [String] The IBAN bank account's last two digits.
      define_attribute :last_two, String

      # @!attribute object
      #   @return [String]
      define_attribute :object, String

      # @!attribute routing_number
      #   @return [String] The bank account's routing number. Only present for ACH payment methods.
      define_attribute :routing_number, String

      # @!attribute routing_number_bank
      #   @return [String] The bank name of this routing number.
      define_attribute :routing_number_bank, String
    end
  end
end

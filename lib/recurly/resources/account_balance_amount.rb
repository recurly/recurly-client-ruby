# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountBalanceAmount < Resource

      # @!attribute amount
      #   @return [Float] Total amount the account is past due.
      define_attribute :amount, Float

      # @!attribute available_credit_amount
      #   @return [Float] Total amount of the open balances on credit invoices for the account.
      define_attribute :available_credit_amount, Float

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute processing_prepayment_amount
      #   @return [Float] Total amount for the prepayment credit invoices in a `processing` state on the account.
      define_attribute :processing_prepayment_amount, Float
    end
  end
end

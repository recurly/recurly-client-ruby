# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalRefund < Request

      # @!attribute description
      #   @return [String] Used as the refund transactions' description.
      define_attribute :description, String

      # @!attribute payment_method
      #   @return [String] Payment method used for external refund transaction.
      define_attribute :payment_method, String, { :enum => ["credit_card", "paypal", "amazon", "roku", "ach", "apple_pay", "sepadirectdebit", "eft", "wire_transfer", "money_order", "check", "other"] }

      # @!attribute refunded_at
      #   @return [DateTime] Date the external refund payment was made. Defaults to the current date-time.
      define_attribute :refunded_at, DateTime
    end
  end
end

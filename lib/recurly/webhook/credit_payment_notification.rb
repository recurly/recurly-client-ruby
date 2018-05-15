module Recurly
  module Webhook
    # The CreditPayment class provides a generic interface
    # for credit-payment-related webhook notifications.
    class CreditPaymentNotification < Notification
      # @return [Account]
      has_one :account
      # @return [CreditPayment]
      has_one :credit_payment
    end
  end
end

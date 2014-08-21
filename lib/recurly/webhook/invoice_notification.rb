module Recurly
  module Webhook
    # The InvoiceNotification class provides a generic interface
    # for account-related webhook notifications.
    class InvoiceNotification < Notification
      # @return [Account]
      has_one :account
      # @return [Invoice]
      has_one :invoice
    end
  end
end

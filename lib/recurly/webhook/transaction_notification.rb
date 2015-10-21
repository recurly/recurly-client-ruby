module Recurly
  module Webhook
    # The TransactionNotification class provides a generic interface
    # for account-related webhook notifications.
    class TransactionNotification < Notification
      # @return [Account]
      has_one :account
      # @return [Transaction]
      has_one :transaction
    end
  end
end

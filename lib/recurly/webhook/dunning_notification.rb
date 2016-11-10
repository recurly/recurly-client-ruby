module Recurly
  module Webhook
    class DunningNotification < Notification
      # @return [Account]
      has_one :account
      # @return [Subscription]
      has_one :subscription
      # @return [Invoice]
      has_one :invoice
      # @return [Transaction]
      has_one :transaction
    end
  end
end

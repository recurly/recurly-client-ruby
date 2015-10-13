module Recurly
  module Webhook
    # The SubscriptionNotification class provides a generic interface
    # for account-related webhook notifications.
    class SubscriptionNotification < Notification
      # @return [Account]
      has_one :account
      # @return [Subscription]
      has_one :subscription
    end
  end
end

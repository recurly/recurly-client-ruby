module Recurly
  module Webhook
    class CanceledSubscriptionNotification < Resource
      # @return [Account]
      has_one :account
      # @return [Subscription]
      has_one :subscription
    end
  end
end

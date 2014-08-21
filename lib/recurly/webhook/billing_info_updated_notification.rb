module Recurly
  module Webhook
    class BillingInfoUpdatedNotification < Resource
      # @return [Account]
      has_one :account
    end
  end
end

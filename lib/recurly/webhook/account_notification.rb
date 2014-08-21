module Recurly
  module Webhook
    # The AccountNotification class provides a generic interface
    # for account-related webhook notifications.
    class AccountNotification < Resource
      # @return [Account]
      has_one :account
    end
  end
end

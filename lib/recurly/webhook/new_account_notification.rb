module Recurly
  module Webhook
    class NewAccountNotification < Resource
      # @return [Account]
      has_one :account
    end
  end
end

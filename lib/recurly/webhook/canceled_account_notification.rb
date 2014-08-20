module Recurly
  module Webhook
    class CanceledAccountNotification < Resource
      # @return [Account]
      has_one :account
    end
  end
end
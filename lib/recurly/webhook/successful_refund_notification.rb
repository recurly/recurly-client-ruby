module Recurly
  module Webhook
    class SuccessfulRefundNotification < Resource
      # @return [Account]
      has_one :account
      # @return [Transaction]
      has_one :transaction
    end
  end
end

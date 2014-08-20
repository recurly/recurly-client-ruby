module Recurly
  module Webhook
    class PastDueInvoiceNotification < Resource
      # @return [Account]
      has_one :account
      # @return [Invoice]
      has_one :invoice
    end
  end
end
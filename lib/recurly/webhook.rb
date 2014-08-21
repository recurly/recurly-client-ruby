module Recurly
  # The Webhook class handles delegating the webhook request body to the appropriate
  # notification class. Notification classes enapsualte the supplied data, providing
  # access to account details, as well as subscription, invoice, and transaction
  # details where available.
  #
  # @example
  #   Recurly::Webhook.parse(xml_body)  # => #<Recurly::Webhook::NewAccountNotification ...>
  module Webhook
    autoload :BillingInfoUpdatedNotification,   'recurly/webhook/billing_info_updated_notification'
    autoload :CanceledSubscriptionNotification, 'recurly/webhook/canceled_subscription_notification'
    autoload :CanceledAccountNotification,      'recurly/webhook/canceled_account_notification'
    autoload :ClosedInvoiceNotification,        'recurly/webhook/closed_invoice_notification'
    autoload :ExpiredSubscriptionNotification,  'recurly/webhook/expired_subscription_notification'
    autoload :FailedPaymentNotification,        'recurly/webhook/failed_payment_notification'
    autoload :NewAccountNotification,           'recurly/webhook/new_account_notification'
    autoload :NewInvoiceNotification,           'recurly/webhook/new_invoice_notification'
    autoload :NewSubscriptionNotification,      'recurly/webhook/new_subscription_notification'
    autoload :PastDueInvoiceNotification,       'recurly/webhook/past_due_invoice_notification'
    autoload :ReactivatedAccountNotification,   'recurly/webhook/reactivated_account_notification'
    autoload :RenewedSubscriptionNotification,  'recurly/webhook/renewed_subscription_notification'
    autoload :SuccessfulPaymentNotification,    'recurly/webhook/successful_payment_notification'
    autoload :SuccessfulRefundNotification,     'recurly/webhook/successful_refund_notification'
    autoload :UpdatedSubscriptionNotification,  'recurly/webhook/updated_subscription_notification'
    autoload :VoidPaymentNotification,          'recurly/webhook/void_payment_notification'
    
    # This exception is raised if the Webhook Notification initialization fails
    class NotificationError < Error
    end
    
    # @return [Resource] A notification.
    # @raise [NotificationError] For unknown or invalid notifications.
    def self.parse xml_body
      xml = XML.new xml_body
      class_name = Helper.classify xml.name
      
      if Webhook.const_defined?(class_name, false)
        klass = Webhook.const_get class_name
        klass.from_xml xml_body
      else
        raise NotificationError, "'#{class_name}' is not a recognized notification"
      end
    end
  end
end

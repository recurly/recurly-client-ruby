module Recurly
  # The Webhook class handles delegating the webhook request body to the appropriate
  # notification class. Notification classes enapsualte the supplied data, providing
  # access to account details, as well as subscription, invoice, and transaction
  # details where available.
  #
  # @example
  #   Recurly::Webhook.parse(xml_body)  # => #<Recurly::Webhook::NewAccountNotification ...>
  #
  #   notification = Recurly::Webhook.parse(xml_body)
  #   case notification
  #   when Recurly::Webhook::NewAccountNoficiation
  #     # A new account was created
  #     ...
  #   when Recurly::Webhook::NewSubscriptionNotification
  #     # A new subscription was added
  #     ...
  #   when Recurly::Webhook::SubscriptionNotification
  #     # A subscription-related notification was sent
  #     ...
  #   end
  module Webhook
    autoload :Notification,                         'recurly/webhook/notification'
    autoload :AccountNotification,                  'recurly/webhook/account_notification'
    autoload :SubscriptionNotification,             'recurly/webhook/subscription_notification'
    autoload :InvoiceNotification,                  'recurly/webhook/invoice_notification'
    autoload :TransactionNotification,              'recurly/webhook/transaction_notification'
    autoload :DunningNotification,                  'recurly/webhook/dunning_notification'
    autoload :CreditPaymentNotification,            'recurly/webhook/credit_payment_notification'
    autoload :BillingInfoUpdatedNotification,       'recurly/webhook/billing_info_updated_notification'
    autoload :CanceledSubscriptionNotification,     'recurly/webhook/canceled_subscription_notification'
    autoload :CanceledAccountNotification,          'recurly/webhook/canceled_account_notification'
    autoload :ClosedInvoiceNotification,            'recurly/webhook/closed_invoice_notification'
    autoload :ClosedCreditInvoiceNotification,      'recurly/webhook/closed_credit_invoice_notification'
    autoload :NewCreditInvoiceNotification,         'recurly/webhook/new_credit_invoice_notification'
    autoload :ProcessingCreditInvoiceNotification,  'recurly/webhook/processing_credit_invoice_notification'
    autoload :ReopenedCreditInvoiceNotification,    'recurly/webhook/reopened_credit_invoice_notification'
    autoload :VoidedCreditInvoiceNotification,      'recurly/webhook/voided_credit_invoice_notification'
    autoload :NewCreditPaymentNotification,         'recurly/webhook/new_credit_payment_notification'
    autoload :VoidedCreditPaymentNotification,      'recurly/webhook/voided_credit_payment_notification'
    autoload :ExpiredSubscriptionNotification,      'recurly/webhook/expired_subscription_notification'
    autoload :FailedPaymentNotification,            'recurly/webhook/failed_payment_notification'
    autoload :NewAccountNotification,               'recurly/webhook/new_account_notification'
    autoload :UpdatedAccountNotification,           'recurly/webhook/updated_account_notification'
    autoload :NewInvoiceNotification,               'recurly/webhook/new_invoice_notification'
    autoload :NewChargeInvoiceNotification,         'recurly/webhook/new_charge_invoice_notification'
    autoload :ProcessingChargeInvoiceNotification,  'recurly/webhook/processing_charge_invoice_notification'
    autoload :PastDueChargeInvoiceNotification,     'recurly/webhook/past_due_charge_invoice_notification'
    autoload :PaidChargeInvoiceNotification,        'recurly/webhook/paid_charge_invoice_notification'
    autoload :FailedChargeInvoiceNotification,      'recurly/webhook/failed_charge_invoice_notification'
    autoload :ReopenedChargeInvoiceNotification,    'recurly/webhook/reopened_charge_invoice_notification'
    autoload :NewSubscriptionNotification,          'recurly/webhook/new_subscription_notification'
    autoload :PastDueInvoiceNotification,           'recurly/webhook/past_due_invoice_notification'
    autoload :ReactivatedAccountNotification,       'recurly/webhook/reactivated_account_notification'
    autoload :RenewedSubscriptionNotification,      'recurly/webhook/renewed_subscription_notification'
    autoload :SuccessfulPaymentNotification,        'recurly/webhook/successful_payment_notification'
    autoload :SuccessfulRefundNotification,         'recurly/webhook/successful_refund_notification'
    autoload :UpdatedSubscriptionNotification,      'recurly/webhook/updated_subscription_notification'
    autoload :VoidPaymentNotification,              'recurly/webhook/void_payment_notification'
    autoload :ProcessingPaymentNotification,        'recurly/webhook/processing_payment_notification'
    autoload :ProcessingInvoiceNotification,        'recurly/webhook/processing_invoice_notification'
    autoload :ScheduledPaymentNotification,         'recurly/webhook/scheduled_payment_notification'
    autoload :NewDunningEventNotification,          'recurly/webhook/new_dunning_event_notification'
    autoload :GiftCardNotification,                 'recurly/webhook/gift_card_notification'
    autoload :PurchasedGiftCardNotification,        'recurly/webhook/purchased_gift_card_notification'
    autoload :RedeemedGiftCardNotification,         'recurly/webhook/redeemed_gift_card_notification'
    autoload :UpdatedBalanceGiftCardNotification,   'recurly/webhook/updated_balance_gift_card_notification'
    autoload :NewUsageNotification,                 'recurly/webhook/new_usage_notification'
    autoload :TransactionAuthorizedNotification,    'recurly/webhook/transaction_authorized_notification'
    autoload :LowBalanceGiftCardNotification,       'recurly/webhook/low_balance_gift_card_notification'
    autoload :TransactionStatusUpdatedNotification, 'recurly/webhook/transaction_status_updated_notification'
    autoload :UpdatedInvoiceNotification,           'recurly/webhook/updated_invoice_notification'
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

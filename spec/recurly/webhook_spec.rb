require 'spec_helper'

def request with
  get_raw_xml "../fixtures/webhooks/#{with}.xml"
end

describe Webhook do
  describe ".parse" do
    it "must return BillingInfoUpdatedNotification instance" do
      Webhook.parse(request 'billing-info-updated-notification').must_be_instance_of Webhook::BillingInfoUpdatedNotification
    end

    it "must return CanceledAccountNotification instance" do
      Webhook.parse(request 'canceled-account-notification').must_be_instance_of Webhook::CanceledAccountNotification
    end

    it "must return CanceledSubscriptionNotification instance" do
      Webhook.parse(request 'canceled-subscription-notification').must_be_instance_of Webhook::CanceledSubscriptionNotification
    end

    it "must return ClosedInvoiceNotification instance" do
      Webhook.parse(request 'closed-invoice-notification').must_be_instance_of Webhook::ClosedInvoiceNotification
    end
    
    it "must return ClosedInvoiceNotification instance (manual)" do
      Webhook.parse(request 'closed-invoice-notification-manual').must_be_instance_of Webhook::ClosedInvoiceNotification
    end

    it "must return ExpiredSubscriptionNotification instance" do
      Webhook.parse(request 'expired-subscription-notification').must_be_instance_of Webhook::ExpiredSubscriptionNotification
    end

    it "must return FailedPaymentNotification instance" do
      Webhook.parse(request 'failed-payment-notification').must_be_instance_of Webhook::FailedPaymentNotification
    end

    it "must return NewAccountNotification instance" do
      Webhook.parse(request 'new-account-notification').must_be_instance_of Webhook::NewAccountNotification
    end

    it "must return UpdatedAccountNotification instance" do
      Webhook.parse(request 'updated-account-notification').must_be_instance_of Webhook::UpdatedAccountNotification
    end

    it "must return NewInvoiceNotification instance" do
      Webhook.parse(request 'new-invoice-notification').must_be_instance_of Webhook::NewInvoiceNotification
    end
    
    it "must return NewInvoiceNotification instance (manual)" do
      Webhook.parse(request 'new-invoice-notification-manual').must_be_instance_of Webhook::NewInvoiceNotification
    end

    it "must return NewSubscriptionNotification instance" do
      Webhook.parse(request 'new-subscription-notification').must_be_instance_of Webhook::NewSubscriptionNotification
    end

    it "must return PastDueInvoiceNotification instance" do
      Webhook.parse(request 'past-due-invoice-notification').must_be_instance_of Webhook::PastDueInvoiceNotification
    end
    
    it "must return PastDueInvoiceNotification instance (manual)" do
      Webhook.parse(request 'past-due-invoice-notification-manual').must_be_instance_of Webhook::PastDueInvoiceNotification
    end

    it "must return ReactivatedAccountNotification instance" do
      Webhook.parse(request 'reactivated-account-notification').must_be_instance_of Webhook::ReactivatedAccountNotification
    end

    it "must return RenewedSubscriptionNotification instance" do
      Webhook.parse(request 'renewed-subscription-notification').must_be_instance_of Webhook::RenewedSubscriptionNotification
    end

    it "must return SuccessfulPaymentNotification instance" do
      Webhook.parse(request 'successful-payment-notification').must_be_instance_of Webhook::SuccessfulPaymentNotification
    end
    
    it "must return SuccessfulPaymentNotification instance (manual)" do
      Webhook.parse(request 'successful-payment-notification-manual').must_be_instance_of Webhook::SuccessfulPaymentNotification
    end

    it "must return SuccessfulRefundNotification instance" do
      Webhook.parse(request 'successful-refund-notification').must_be_instance_of Webhook::SuccessfulRefundNotification
    end

    it "must return UpdatedSubscriptionNotification instance" do
      Webhook.parse(request 'updated-subscription-notification').must_be_instance_of Webhook::UpdatedSubscriptionNotification
    end

    it "must return VoidPaymentNotification instance" do
      Webhook.parse(request 'void-payment-notification').must_be_instance_of Webhook::VoidPaymentNotification
    end
    
    it "must handle unknown notifications" do
      proc { Webhook.parse(request 'unknown-notification') }.must_raise Webhook::NotificationError
    end
  end
end

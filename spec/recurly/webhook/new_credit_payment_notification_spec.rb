require 'spec_helper'

describe Webhook::NewCreditPaymentNotification do
  let(:notification) { Webhook::NewCreditPaymentNotification.from_xml(get_raw_xml 'webhooks/new-credit-payment-notification.xml') }

  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end

    it "must have an account_code" do
      notification.account.account_code.must_equal '1234'
    end
  end

  describe "credit_payment" do
    it "must return the credit_payment" do
      notification.credit_payment.must_be_instance_of CreditPayment
    end
  end
end

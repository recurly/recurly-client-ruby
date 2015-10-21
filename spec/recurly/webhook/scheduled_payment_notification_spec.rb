require 'spec_helper'

describe Webhook::ScheduledPaymentNotification do
  let(:notification) { Webhook::ScheduledPaymentNotification.from_xml(get_raw_xml 'webhooks/scheduled-payment-notification.xml') }

  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end

    it "must have an account_code" do
      notification.account.account_code.must_equal '1'
    end
  end

  describe "transaction" do
    it "must return the subscription" do
      notification.transaction.must_be_instance_of Transaction
    end

    describe 'status' do
      it "must have a scheduled status" do
        notification.transaction.status.must_equal 'scheduled'
      end
    end
  end
end

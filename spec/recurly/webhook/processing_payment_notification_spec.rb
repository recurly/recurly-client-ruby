require 'spec_helper'

describe Webhook::ProcessingPaymentNotification do
  let(:notification) { Webhook::ProcessingPaymentNotification.from_xml(get_raw_xml 'webhooks/processing-payment-notification.xml') }

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

    describe 'state' do
      it "must have a processing state" do
        notification.transaction.status.must_equal 'processing'
       end
    end
  end
end

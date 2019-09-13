require 'spec_helper'

describe Webhook::FraudInfoUpdatedNotification do
  let(:notification) { Webhook::FraudInfoUpdatedNotification.from_xml(get_raw_xml 'webhooks/fraud-info-updated-notification.xml') }
  
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
  end
end

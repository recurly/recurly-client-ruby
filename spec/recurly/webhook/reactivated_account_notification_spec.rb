require 'spec_helper'

describe Webhook::ReactivatedAccountNotification do
  let(:notification) { Webhook::ReactivatedAccountNotification.from_xml(get_raw_xml 'webhooks/reactivated-account-notification.xml') }
  
  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end
  
    it "must have an account_code" do
      notification.account.account_code.must_equal '1'
    end
  end
end

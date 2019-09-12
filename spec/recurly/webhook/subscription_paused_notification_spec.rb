require 'spec_helper'

describe Webhook::SubscriptionPausedNotification do
  let (:notification) { Webhook::SubscriptionPausedNotification.from_xml(get_raw_xml 'webhooks/subscription-paused-notification.xml') }

  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end
  
    it "must have an account_code" do
      notification.account.account_code.must_equal '1'
    end
  end
  
  describe "subscription" do
    it "must return the subscription" do
      notification.subscription.must_be_instance_of Subscription
    end
  end
end
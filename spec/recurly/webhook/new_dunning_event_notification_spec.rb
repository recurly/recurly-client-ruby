require 'spec_helper'

describe Webhook::NewSubscriptionNotification do
  let(:notification) { Webhook::NewDunningEventNotification.from_xml(get_raw_xml 'webhooks/new-dunning-event-notification.xml') }

  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end

    it "must have an account_code" do
      notification.account.account_code.must_equal '09f299492d21'
    end
  end

  describe "subscription" do
    it "must return the subscription" do
      notification.subscription.must_be_instance_of Subscription
    end

    it "must have a uuid" do
      notification.subscription.uuid.must_equal '396e4e17640ca516c2f3a84e47ae91dd'
    end
  end

  describe "invoice" do
    it "must return the invoice" do
      notification.invoice.must_be_instance_of Invoice
    end

    it "must have a uuid" do
      notification.invoice.uuid.must_equal 'inv-7wr0r2xuawwCjO'
    end
  end

  describe "transaction" do
    it "must return the transaction" do
      notification.transaction.must_be_instance_of Transaction
    end

    it "must have a id" do
      notification.transaction.id.must_equal '397083a9a871b53a3d5a4c469fa1216a'
    end
  end
end

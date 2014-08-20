require 'spec_helper'

describe Webhook::ClosedInvoiceNotification do
  let(:notification) { Webhook::ClosedInvoiceNotification.from_xml(get_raw_xml 'webhooks/closed-invoice-notification.xml') }
  
  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end
  
    it "must have an account_code" do
      notification.account.account_code.must_equal '1'
    end
  end
  
  describe "invoice" do
    it "must return the invoice" do
      notification.invoice.must_be_instance_of Invoice
    end
  end
end

require 'spec_helper'

describe Invoice do
  describe "#subscription" do
    it "has a subscription if present" do
      stub_api_request :get, 'invoices/created-invoice', 'invoices/create-201'
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'

      invoice = Invoice.find 'created-invoice'
      invoice.subscription.must_be_instance_of Subscription
    end

    it "subscription is nil if not present" do
      stub_api_request :get, 'invoices/created-invoice', 'invoices/show-200-nosub'

      invoice = Invoice.find 'created-invoice'
      invoice.subscription.must_equal nil
    end
  end

  describe 'attributes' do
    it 'has a tax type if taxed' do
      stub_api_request :get, 'invoices/taxed-invoice', 'invoices/show-200-taxed'

      invoice = Invoice.find 'taxed-invoice'
      invoice.tax_type.must_equal 'usst'
    end
  end
end

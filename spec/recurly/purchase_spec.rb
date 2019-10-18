require 'spec_helper'

describe Purchase do
  let(:purchase) do
    Purchase.new(
      account: {account_code: 'account123'},
      transaction_type: 'moto',
      adjustments: [
        {
          product_code: 'product_code',
          unit_amount_in_cents: 1_000,
          quantity: 1
        }
      ],
      subscriptions: [
        {
          plan_code: 'plan_code',
          subscription_add_ons: [
            add_on_code: 'add_on_code',
            unit_amount_in_cents: 200
          ]
        }
      ],
      shipping_address_id: 1234,
      shipping_fees: [
        shipping_method_code: 'fedex_ground',
        shipping_amount_in_cents: 999
      ],
      shipping_address:  {
        nickname: "Work",
        first_name: "Verena",
        last_name: "Example",
        company: "Recurly Inc.",
        phone: "555-555-5555",
        email: "verena@example.com",
        address1: "400 Alabama St.",
        city: "San Francisco",
        state: "CA",
        zip: "94110",
        country: "US"
      }
    )
  end

  describe "Purchase.invoice!" do
    it "should return an invoice_collection when valid" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-201')
      collection = Purchase.invoice!(purchase)
      collection.charge_invoice.must_be_instance_of Invoice
      shipping_address = collection.charge_invoice.line_items.first.shipping_address
      shipping_address.must_be_instance_of ShippingAddress
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.invoice!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
      purchase.subscriptions.first.errors["subscription_add_ons"].must_equal ["is invalid"]
    end
    it "should raise a Transaction::Error error when transaction fails" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-declined-422')
      proc {Purchase.invoice!(purchase)}.must_raise Transaction::DeclinedError
    end
  end

  describe "Purchase.preview!" do
    it "should return a preview invoice when valid" do
      stub_api_request(:post, 'purchases/preview', 'purchases/preview-201')
      preview_collection = Purchase.preview!(purchase)
      preview_collection.charge_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases/preview', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.preview!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
    end
  end

  describe "Purchase.authorize!" do
    it "should return an authorized invoice when valid" do
      stub_api_request(:post, 'purchases/authorize', 'purchases/preview-201')
      authorized_collection = Purchase.authorize!(purchase)
      authorized_invoice = authorized_collection.charge_invoice
      authorized_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases/authorize', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.authorize!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
    end
  end

  describe "Purchase.pending!" do
    it "should return an authorized invoice when valid" do
      stub_api_request(:post, 'purchases/pending', 'purchases/preview-201')
      authorized_collection = Purchase.pending!(purchase)
      authorized_invoice = authorized_collection.charge_invoice
      authorized_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases/pending', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.pending!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
    end
  end

  describe "Purchase.capture!" do
    it "should return a captured invoice collection when valid" do
      tr_uuid = 'abcd1234'
      stub_api_request(:post, "purchases/transaction-uuid-#{tr_uuid}/capture", 'purchases/preview-201')
      captured_collection = Purchase.capture!(tr_uuid)
      captured_invoice = captured_collection.charge_invoice
      captured_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      tr_uuid = 'abcd1234'
      stub_api_request(:post, "purchases/transaction-uuid-#{tr_uuid}/capture", 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.capture!(tr_uuid)}.must_raise Resource::Invalid
    end
  end

  describe "Purchase.cancel!" do
    it "should return a canceled invoice collection when valid" do
      tr_uuid = 'abcd1234'
      stub_api_request(:post, "purchases/transaction-uuid-#{tr_uuid}/cancel", 'purchases/preview-201')
      canceled_collection = Purchase.cancel!(tr_uuid)
      canceled_invoice = canceled_collection.charge_invoice
      canceled_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      tr_uuid = 'abcd1234'
      stub_api_request(:post, "purchases/transaction-uuid-#{tr_uuid}/cancel", 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.cancel!(tr_uuid)}.must_raise Resource::Invalid
    end
  end
end

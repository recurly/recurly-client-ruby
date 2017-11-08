require 'spec_helper'

describe Purchase do
  let(:purchase) do
    Purchase.new(
      account: {account_code: 'account123'},
      adjustments: [
        {
          product_code: 'product_code',
          unit_amount_in_cents: 1_000,
          quantity: 1
        }
      ]
    )
  end

  describe "Purchase.invoice!" do
    it "should return an invoice when valid" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-201')
      invoice = Purchase.invoice!(purchase)
      invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.invoice!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
    end
    it "should raise a Transaction::Error error when transaction fails" do
      stub_api_request(:post, 'purchases', 'purchases/invoice-declined-422')
      proc {Purchase.invoice!(purchase)}.must_raise Transaction::DeclinedError
    end
  end

  describe "Purchase.preview!" do
    it "should return a preview invoice when valid" do
      stub_api_request(:post, 'purchases/preview', 'purchases/preview-201')
      preview_invoice = Purchase.preview!(purchase)
      preview_invoice.must_be_instance_of Invoice
    end
    it "should raise an Invalid error when data is invalid" do
      stub_api_request(:post, 'purchases/preview', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.preview!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors["unit_amount_in_cents"].must_equal ["is not a number"]
    end
  end
end

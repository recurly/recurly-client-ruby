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

    it 'can access notes if there' do
      stub_api_request :get, 'invoices/created-invoice', 'invoices/show-200-with-notes'

      invoice = Invoice.find 'created-invoice'
      invoice.customer_notes.must_equal 'Some Customer Notes'
      invoice.terms_and_conditions.must_equal 'Some Terms and Conditions'
    end
  end

  describe "line item refund" do
    before do
      stub_api_request :get, 'invoices/refundable-invoice', 'invoices/show-200-refundable'
      stub_api_request :post, 'invoices/refundable-invoice/refund', 'invoices/refund-201'

      @invoice = Invoice.find 'refundable-invoice'

      @line_items = @invoice.line_items.values.map do |adjustment|
        { adjustment: adjustment, quantity: 1, prorate: false }
      end
    end

    describe "#refund" do
      it "creates a refund invoice for the line items refunded" do
        refund_invoice = @invoice.refund @line_items
        refund_invoice.must_be_instance_of Invoice
        refund_invoice.line_items.each do |key, adjustment|
          adjustment.quantity_remaining.must_equal 1
        end
      end
    end

    describe "#refund_to_xml" do
      it "must serialize line_items" do
        @invoice.send(:refund_line_items_to_xml, @line_items).must_equal(
          '<invoice><line_items><adjustment><uuid>charge1</uuid><quantity>1</quantity><prorate>false</prorate></adjustment></line_items></invoice>'
        )
      end
    end
  end

  describe "open amount refund" do
    before do
      stub_api_request :get, 'invoices/refundable-invoice', 'invoices/show-200-refundable'
      stub_api_request :post, 'invoices/refundable-invoice/refund', 'invoices/refund_amount-201'

      @invoice = Invoice.find 'refundable-invoice'
    end

    describe "#refund" do
      it "creates a refund invoice for the line items refunded" do
        refund_invoice = @invoice.refund_amount 1000
        refund_invoice.must_be_instance_of Invoice
        refund_invoice.amount_remaining_in_cents.must_equal 100
      end
    end

    describe "#refund_to_xml" do
      it "must serialize amount_in_cents" do
        @invoice.send(:refund_amount_to_xml, 1000).must_equal(
          '<invoice><amount_in_cents>1000</amount_in_cents></invoice>'
        )
      end
    end
  end
end

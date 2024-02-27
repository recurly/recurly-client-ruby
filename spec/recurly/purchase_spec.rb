require 'spec_helper'
require 'pry'

describe Purchase do
  let(:plan_code) { 'plan_code' }
  let(:purchase) do
    Purchase.new(
      account: {account_code: 'account123'},
      transaction_type: 'moto',
      adjustments: [
        {
          product_code: 'product_code',
          unit_amount_in_cents: 1_000,
          quantity: 1,
          liability_gl_account_id: 'ad8h3layw',
          revenue_gl_account_id: 'ydu5owk',
          performance_obligation_id: '5',
          custom_fields: [
            {
              name: 'field1',
              value: 'priceless'
            }
          ]
        }
      ],
      subscriptions: [
        {
          plan_code: plan_code,
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

  describe 'Purchase.invoice!' do
    it 'should return an invoice_collection when valid' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-201')
      binding.pry
      collection = Purchase.invoice!(purchase)
      collection.charge_invoice.must_be_instance_of Invoice
      shipping_address = collection.charge_invoice.line_items.first.shipping_address
      shipping_address.must_be_instance_of ShippingAddress
    end

    it 'should contain action result attribute on response' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-with-action-result-201')
      collection = Purchase.invoice!(purchase)
      expect(collection.charge_invoice.transactions.first.action_result).must_equal('example')
    end

    it 'the first ramp interval unit amount is reflected in these expected attributes' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-with-ramp-pricing-201')
      collection = Purchase.invoice!(purchase)
      charge_invoice = collection.charge_invoice

      charge_invoice.total_in_cents.must_equal 7000
      charge_invoice.subtotal_before_discount_in_cents.must_equal 7000
      charge_invoice.subtotal_in_cents.must_equal 7000
      charge_invoice.refundable_total_in_cents.must_equal 7000

      charge_invoice.line_items.first.unit_amount_in_cents.must_equal 7000
      charge_invoice.line_items.first.refundable_total_in_cents.must_equal 7000
      charge_invoice.line_items.first.total_in_cents.must_equal 7000

      charge_invoice.transactions.first.amount_in_cents.must_equal 7000
    end

    it 'should raise an Invalid error when data is invalid' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-422')
      # ensure error is raised
      proc { Purchase.invoice!(purchase) }.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors['unit_amount_in_cents'].must_equal ['is not a number']
      purchase.subscriptions.first.errors['subscription_add_ons'].must_equal ['is invalid']
    end

    it 'should raise a Transaction::Error error when transaction fails' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-declined-422')
      proc { Purchase.invoice!(purchase) }.must_raise Transaction::DeclinedError
    end

    it 'should return custom fields for an adjustment on a purchase that has custom fields' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-422')

      purchase.adjustments.first.custom_fields.first.name.must_equal 'field1'
      purchase.adjustments.first.custom_fields.first.value.must_equal 'priceless'
    end

    it 'should return RevRec details for an adjustment on a purchase that has RevRec details' do
      stub_api_request(:post, 'purchases', 'purchases/invoice-201')

      purchase.adjustments.first.liability_gl_account_id.must_equal 'ad8h3layw'
      purchase.adjustments.first.revenue_gl_account_id.must_equal 'ydu5owk'
      purchase.adjustments.first.performance_obligation_id.must_equal '5'
    end
  end

  describe 'Purchase.preview!' do
    it 'should return a preview invoice when valid' do
      stub_api_request(:post, 'purchases/preview', 'purchases/preview-201')
      preview_collection = Purchase.preview!(purchase)
      preview_collection.charge_invoice.must_be_instance_of Invoice
    end

    it 'the first ramp interval unit amount is reflected in these expected attributes' do
      stub_api_request(:post, 'purchases/preview', 'purchases/preview-with-ramp-pricing-201')
      collection = Purchase.preview!(purchase)
      charge_invoice = collection.charge_invoice

      charge_invoice.total_in_cents.must_equal 7000
      charge_invoice.subtotal_before_discount_in_cents.must_equal 7000
      charge_invoice.subtotal_in_cents.must_equal 7000
      charge_invoice.refundable_total_in_cents.must_equal 7000

      charge_invoice.line_items.first.unit_amount_in_cents.must_equal 7000
      charge_invoice.line_items.first.refundable_total_in_cents.must_equal 7000
      charge_invoice.line_items.first.total_in_cents.must_equal 7000
    end

    it 'should raise an Invalid error when data is invalid' do
      stub_api_request(:post, 'purchases/preview', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.preview!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors['unit_amount_in_cents'].must_equal ['is not a number']
    end
  end

  describe 'Purchase.authorize!' do
    it 'should return an authorized invoice when valid' do
      stub_api_request(:post, 'purchases/authorize', 'purchases/preview-201')
      authorized_collection = Purchase.authorize!(purchase)
      authorized_invoice = authorized_collection.charge_invoice
      authorized_invoice.must_be_instance_of Invoice
    end

    it 'the first ramp interval unit amount is reflected in these expected attributes' do
      stub_api_request(:post, 'purchases/authorize', 'purchases/authorize-with-ramp-pricing-201')
      collection = Purchase.authorize!(purchase)
      charge_invoice = collection.charge_invoice

      charge_invoice.total_in_cents.must_equal 7000
      charge_invoice.subtotal_before_discount_in_cents.must_equal 7000
      charge_invoice.subtotal_in_cents.must_equal 7000
      charge_invoice.refundable_total_in_cents.must_equal 7000

      charge_invoice.line_items.first.unit_amount_in_cents.must_equal 7000
      charge_invoice.line_items.first.refundable_total_in_cents.must_equal 7000
      charge_invoice.line_items.first.total_in_cents.must_equal 7000

      charge_invoice.transactions.first.amount_in_cents.must_equal 7000
    end

    it 'should raise an Invalid error when data is invalid' do
      stub_api_request(:post, 'purchases/authorize', 'purchases/invoice-422')
      # ensure error is raised
      proc {Purchase.authorize!(purchase)}.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors['unit_amount_in_cents'].must_equal ['is not a number']
    end
  end

  describe 'Purchase.pending!' do
    it 'should return an authorized invoice when valid' do
      stub_api_request(:post, 'purchases/pending', 'purchases/preview-201')
      authorized_collection = Purchase.pending!(purchase)
      authorized_invoice = authorized_collection.charge_invoice
      authorized_invoice.must_be_instance_of Invoice
    end

    it 'the first ramp interval unit amount is reflected in these expected attributes' do
      stub_api_request(:post, 'purchases/pending', 'purchases/pending-with-ramp-pricing-201')
      collection = Purchase.pending!(purchase)
      charge_invoice = collection.charge_invoice

      charge_invoice.total_in_cents.must_equal 7000
      charge_invoice.subtotal_before_discount_in_cents.must_equal 7000
      charge_invoice.subtotal_in_cents.must_equal 7000
      charge_invoice.refundable_total_in_cents.must_equal 7000

      charge_invoice.line_items.first.unit_amount_in_cents.must_equal 7000
      charge_invoice.line_items.first.refundable_total_in_cents.must_equal 7000
      charge_invoice.line_items.first.total_in_cents.must_equal 7000
    end

    it 'should raise an Invalid error when data is invalid' do
      stub_api_request(:post, 'purchases/pending', 'purchases/invoice-422')
      # ensure error is raised
      proc { Purchase.pending!(purchase) }.must_raise Resource::Invalid
      # ensure error details are mapped back
      purchase.adjustments.first.errors['unit_amount_in_cents'].must_equal ['is not a number']
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

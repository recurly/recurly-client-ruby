require 'spec_helper'

describe Invoice do
  describe "#subscription" do
    it "has a subscription if present" do
      stub_api_request :get, 'invoices/created-invoice', 'invoices/show-200'
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'

      invoice = Invoice.find 'created-invoice'
      invoice.subscriptions.must_be_instance_of Recurly::Resource::Pager
    end

    it "subscription is nil if not present" do
      stub_api_request :get, 'invoices/created-invoice', 'invoices/show-200-nosub'

      invoice = Invoice.find 'created-invoice'
      invoice.subscriptions.must_equal []
    end
  end

  describe 'attributes' do
    it 'should have proper links' do
      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      stub_api_request :get, 'invoices/1001', 'invoices/show-200'

      invoice = Invoice.find('1000')
      invoice.redemptions.must_be_instance_of Resource::Pager
      invoice.subscriptions.must_be_instance_of Resource::Pager
      invoice.original_invoices.must_be_instance_of Resource::Pager
      invoice.original_invoice.must_be_instance_of Invoice
      invoice.credit_payments.must_be_instance_of Array
      invoice.credit_payments.first.must_be_instance_of CreditPayment
    end

    it 'should have surcharge_in_cents' do
      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      invoice = Invoice.find('1000')
      invoice.surcharge_in_cents.must_equal 100
    end

    it "should have dunning_campaign_id" do
      stub_api_request :get, "invoices/1000", "invoices/show-200"
      invoice = Invoice.find("1000")
      invoice.dunning_campaign_id.must_equal("1234abcd")
    end

    it 'includes the invoice number prefix' do
      stub_api_request :get, 'invoices/invoice-with-prefix', 'invoices/show-200-prefix'

      invoice = Invoice.find('invoice-with-prefix')
      invoice.invoice_number.must_equal 1001
      invoice.invoice_number_prefix.must_equal 'GB'
      invoice.invoice_number_with_prefix.must_equal 'GB1001'
    end

    describe 'if taxed' do
      let(:invoice) { Invoice.find 'taxed-invoice' }

      before do
        stub_api_request :get, 'invoices/taxed-invoice', 'invoices/show-200-taxed'
      end

      it 'has a tax type if taxed' do
        invoice.tax_type.must_equal 'usst'
      end

      it 'has a vertex fields' do
        invoice.refund_tax_date.must_equal DateTime.new(2017, 04, 30)
        invoice.refund_geo_code.must_equal 'ABC123'

        tax_types = invoice.tax_types
        tax_types.length.must_equal 3

        tax_type = tax_types.first
        tax_type.must_be_instance_of TaxType
        tax_type.tax_classification.must_equal 'surcharge'
        tax_type.tax_in_cents[:USD].must_equal 115
        tax_type.description.must_equal 'Sales Tax'
      end
    end

    it 'can access notes, net_terms and collection method if there' do
      stub_api_request :get, 'invoices/show-invoice', 'invoices/show-200'

      invoice = Invoice.find 'show-invoice'
      invoice.customer_notes.must_equal 'Some Customer Notes'
      invoice.terms_and_conditions.must_equal 'Some Terms and Conditions'
      invoice.net_terms.must_equal 0
      invoice.collection_method.must_equal 'automatic'
    end

    describe 'with avalara for communications' do
      it 'should have a #tax_details' do
        stub_api_request :get, 'invoices/show-invoice', 'invoices/show-200-taxed'
        invoice = Invoice.find 'show-invoice'

        tax_details = invoice.tax_details
        tax_details.length.must_equal 3
        tax_details.all? { |d| d.must_be_instance_of Recurly::TaxDetail }
        state, county, canada = tax_details

        state.name.must_equal 'california'
        state.type.must_equal 'state'
        state.tax_rate.must_equal 0.065
        state.tax_in_cents.to_i.must_equal 3000
        state.level.must_equal 'state'
        state.billable.must_equal true

        county.name.must_equal 'san francisco'
        county.type.must_equal 'county'
        county.tax_rate.must_equal 0.02
        county.tax_in_cents.to_i.must_equal 2000

        canada.tax_type.must_equal 'GST'
        canada.tax_region.must_equal 'CA'
        canada.tax_rate.must_equal 0.05
        canada.tax_in_cents.to_i.must_equal 20
      end
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
        refund_invoice.original_invoices.must_be_instance_of Recurly::Resource::Pager
        refund_invoice.line_items.each do |key, adjustment|
          adjustment.quantity_remaining.must_equal 1
        end
      end
    end

    describe "#refund_to_xml" do
      it "must serialize line_items" do
        options = {
          credit_customer_notes: 'Credit Notes',
          external_refund: true,
          payment_method: 'check',
          description: 'Check no. 12345678',
          refunded_at: DateTime.new(2018, 12, 1, 0, 0, 0),
          amount_in_cents: 17_500
        }
        @invoice.send(:refund_line_items_to_xml, @line_items, 'credit_first', options).must_equal(
          '<invoice><refund_method>credit_first</refund_method><credit_customer_notes>Credit Notes</credit_customer_notes><external_refund>true</external_refund><payment_method>check</payment_method><description>Check no. 12345678</description><refunded_at>2018-12-01T00:00:00+00:00</refunded_at><amount_in_cents>17500</amount_in_cents><line_items><adjustment><uuid>charge1</uuid><quantity>1</quantity><prorate>false</prorate></adjustment></line_items></invoice>'
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
        refund_invoice.original_invoices.must_be_instance_of Recurly::Resource::Pager
        refund_invoice.amount_remaining_in_cents.must_equal 100
      end
    end

    describe "#refund_to_xml" do
      it "must serialize amount_in_cents" do
        options = {
          credit_customer_notes: 'Credit Notes',
          external_refund: true,
          payment_method: 'check',
          description: 'Check no. 12345678',
          refunded_at: DateTime.new(2018, 12, 1, 0, 0, 0),
          amount_in_cents: 17_500
        }
        @invoice.send(:refund_amount_to_xml, 1000, 'credit_first', options).must_equal(
          '<invoice><refund_method>credit_first</refund_method><amount_in_cents>1000</amount_in_cents><credit_customer_notes>Credit Notes</credit_customer_notes><external_refund>true</external_refund><payment_method>check</payment_method><description>Check no. 12345678</description><refunded_at>2018-12-01T00:00:00+00:00</refunded_at><amount_in_cents>17500</amount_in_cents></invoice>'
        )
      end
    end
  end

  describe "failed_refund" do
    before do
      stub_api_request :get, 'invoices/refundable-invoice', 'invoices/show-200-refundable'
      stub_api_request :post, 'invoices/refundable-invoice/refund', 'invoices/refund-422'

      @invoice = Invoice.find 'refundable-invoice'

      @line_items = @invoice.line_items.values.map do |adjustment|
        { adjustment: adjustment, quantity: 1, prorate: false }
      end
    end

    describe "#refund" do
      it "handles a transaction error response" do
        error = proc {@invoice.refund(@line_items)}.must_raise Transaction::DeclinedError
        error.transaction_error_code.must_equal("deposit_referenced_chargeback")
      end
    end
  end

  describe "#all_transactions" do
    it "must provide a link to all transactions if present" do
      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      invoice = Invoice.find(1000)
      invoice.all_transactions.must_be_instance_of Resource::Pager
      invoice.all_transactions.any?.must_equal true
    end
  end

  describe "#force_collect" do
    it "must call /collect with body" do
      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      stub_api_request :put, 'invoices/created-invoice/collect', 'invoices/show-200-updated'
      invoice = Invoice.find(1000)
      invoice.force_collect(
        transaction_type: 'moto',
        billing_info: Recurly::BillingInfo.new(token_id: '1234')
      )
    end
  end

  describe "#save" do
    it "must update an invoice" do
      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      stub_api_request :put, 'invoices/created-invoice', 'invoices/show-200-updated'
      invoice = Invoice.find(1000)
      invoice.address = Address.new({
        first_name: "P.",
        last_name: "Sherman",
        company: "Dentist Office",
        address1: "42 Wallaby Way",
        address2: "Suite 200",
        city: "Sydney",
        state: "New South Wales",
        country: "Australia",
        zip: "2060"
      })
      invoice.po_number = "9876"
      invoice.terms_and_conditions = "Dentist not responsible for broken teeth."
      invoice.customer_notes = "Oh, well, that's one way to pull a tooth out!"
      invoice.vat_reverse_charge_notes = "can't be changed when invoice was not a reverse charge"
      invoice.net_terms = 1
      invoice.gateway_code = "Some Gateway Code"
      invoice.save()

      invoice.address.must_be_instance_of Address
      invoice.address.first_name.must_equal "P."
      invoice.address.last_name.must_equal "Sherman"
      invoice.address.company.must_equal "Dentist Office"
      invoice.address.address1.must_equal "42 Wallaby Way"
      invoice.address.address2.must_equal "Suite 200"
      invoice.address.city.must_equal "Sydney"
      invoice.address.state.must_equal "New South Wales"
      invoice.address.country.must_equal "Australia"
      invoice.address.zip.must_equal "2060"
      invoice.po_number.must_equal "9876"
      invoice.terms_and_conditions.must_equal "Dentist not responsible for broken teeth."
      invoice.customer_notes.must_equal "Oh, well, that's one way to pull a tooth out!"
      invoice.vat_reverse_charge_notes.must_equal "can't be changed when invoice was not a reverse charge"
      invoice.net_terms.must_equal 1
      invoice.gateway_code.must_equal "Some Gateway Code"
    end
  end
end

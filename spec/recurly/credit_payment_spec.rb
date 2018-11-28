require 'spec_helper'

describe CreditPayment do
  describe ".paginate" do
    it "must return a pager" do
      stub_api_request :get, 'credit_payments', 'credit_payments/index-200'
      pager = CreditPayment.paginate
      pager.must_be_instance_of Resource::Pager
    end
  end

  describe ".find" do
    it "must return and parse a credit payment" do
      stub_api_request :get, 'credit_payments/12345', 'credit_payments/show-200'
      payment = CreditPayment.find('12345')
      payment.must_be_instance_of CreditPayment
      payment.type.must_equal 'payment'
      payment.action.must_equal 'payment'
      payment.currency.must_equal 'USD'
      payment.uuid.must_equal '12345'
      payment.amount_in_cents.must_equal 1000

      stub_api_request :get, 'invoices/1000', 'invoices/show-200'
      stub_api_request :get, 'invoices/1001', 'invoices/show-200'

      payment.original_invoice.must_be_instance_of Invoice
      payment.applied_to_invoice.must_be_instance_of Invoice
    end
  end

  describe 'marshal methods' do
    it 'must return the same instance variables' do
      stub_api_request :get, 'credit_payments/12345', 'credit_payments/show-200'
      credit_payment = CreditPayment.find('12345')

      credit_payment_from_dump = Marshal.load(Marshal.dump(credit_payment))
      credit_payment.instance_variables.must_equal credit_payment_from_dump.instance_variables
    end

    it 'must return the same values' do
      stub_api_request :get, 'credit_payments/12345', 'credit_payments/show-200'
      credit_payment = CreditPayment.find('12345')

      credit_payment_from_dump = Marshal.load(Marshal.dump(credit_payment))
      credit_payment.type.must_equal credit_payment_from_dump.type
    end
  end
end

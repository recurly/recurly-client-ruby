require 'spec_helper'

describe ExternalInvoice do
  let(:external_invoice) {
    ExternalInvoice.new(
      account: Account.new(account_code: 'account_code'),
      external_subscription: ExternalSubscription.new(id: '123abc'),
      state: 'paid',
      currency: 'USD',
      total: '9.98',
      line_items: [
        ExternalCharge.new(
        external_product_reference: ExternalProductReference.new(
          id: "abc123",
          reference_code: "reference_code 1",
          external_connection_type: "appple_app_store",
          created_at: "2023-02-06T19:56:18Z",
          updated_at: "2023-02-06T19:56:18Z"
        ),
        description: 'good',
        unit_amount: '4.99',
        currency: 'USD',
        quantity: 2,
        created_at: '2023-02-07T18:53:55Z',
        updated_at: '2023-02-07T18:53:55Z'
      )],
      purchased_at: "2023-01-13T17:28:02Z",
      created_at: "2022-10-10T21:40:57Z",
      updated_at: "2022-10-10T21:40:57Z"
    )
  }

  describe "#associations" do
    it "has correct associations" do
      expect(external_invoice.line_items[0]).must_be_instance_of ExternalCharge
      expect(external_invoice.external_subscription).must_be_instance_of ExternalSubscription
      expect(external_invoice.account).must_be_instance_of Account
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(external_invoice.state).must_equal('paid')
      expect(external_invoice.currency).must_equal('USD')
      expect(external_invoice.total).must_equal('9.98')
      expect(external_invoice.purchased_at).must_equal('2023-01-13T17:28:02Z')
      expect(external_invoice.created_at).must_equal('2022-10-10T21:40:57Z')
      expect(external_invoice.updated_at).must_equal('2022-10-10T21:40:57Z')
    end
  end
end

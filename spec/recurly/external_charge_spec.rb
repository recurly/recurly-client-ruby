require 'spec_helper'

describe ExternalCharge do
  let(:external_charge) {
    ExternalCharge.new(
      external_product_reference: ExternalProductReference.new(
        id: "abc123",
        reference_code: "reference_code 1",
        external_connection_type: "appple_app_store",
        created_at: "2023-02-06T19:56:18Z",
        updated_at: "2023-02-06T19:56:18Z"
      ),
      external_invoice: ExternalInvoice.new(),
      account: Account.new(account_code: 'account_code'),
      description: 'good',
      unit_amount: '50.72',
      currency: 'USD',
      quantity: 2,
      created_at: '2023-02-07T18:53:55Z',
      updated_at: '2023-02-07T18:53:55Z'
    )
  }

  describe "#associations" do
    it "has correct associations" do
      expect(external_charge.external_invoice).must_be_instance_of ExternalInvoice
      expect(external_charge.external_product_reference).must_be_instance_of ExternalProductReference
      expect(external_charge.account).must_be_instance_of Account
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(external_charge.description).must_equal('good')
      expect(external_charge.unit_amount).must_equal('50.72')
      expect(external_charge.currency).must_equal('USD')
      expect(external_charge.quantity).must_equal(2)
      expect(external_charge.created_at).must_equal('2023-02-07T18:53:55Z')
      expect(external_charge.updated_at).must_equal('2023-02-07T18:53:55Z')
    end
  end
end

require 'spec_helper'

describe ExternalProductReference do
  let(:external_product_reference) {
    ExternalProductReference.new(
      external_product: ExternalProduct.new(name: 'name'),
      id: 'sd28t3zdm59p',
      reference_code: 'abc123',
      external_connection_type: 'google_play_store',
      created_at: '2023-01-23T19:02:40Z',
      updated_at: '2023-02-23T19:02:40Z'
    )
  }
  let(:external_product) {
    stub_api_request :get, 'external_products/abcdef1234567890', 'external_products/show-200'
    ExternalProduct.find('abcdef1234567890')
  }

  describe "#associations" do
    it "has correct associations" do
      expect(external_product_reference.external_product).must_be_instance_of ExternalProduct
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(external_product_reference.reference_code).must_equal('abc123')
      expect(external_product_reference.id).must_equal('sd28t3zdm59p')
      expect(external_product_reference.external_connection_type).must_equal('google_play_store')
      expect(external_product_reference.created_at).must_equal('2023-01-23T19:02:40Z')
      expect(external_product_reference.updated_at).must_equal('2023-02-23T19:02:40Z')
    end
  end

  describe ".get_external_product_references" do
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/external_products/abcdef1234567890/external_product_references",
        "external_products/external_product_references/index-200"
      )
    end

    it "returns an external product reference" do
      external_product_reference = external_product.get_external_product_references[0]

      external_product_reference.must_be_instance_of(ExternalProductReference)
      external_product_reference.id.must_equal('sviw927mygd2')
      external_product_reference.reference_code.must_equal('abcde')
      external_product_reference.external_connection_type.must_equal('apple_app_store')
      external_product_reference.created_at.must_equal(DateTime.new(2023, 5, 11, 22, 8, 14))
      external_product_reference.updated_at.must_equal(DateTime.new(2023, 5, 11, 22, 14, 11))
    end
  end

  describe ".get_external_product_reference" do
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/external_products/abcdef1234567890/external_product_references/sviw927mygd3",
        "external_products/external_product_references/show-200"
      )
    end

    it "returns an external product reference" do
      external_product_reference = external_product.get_external_product_reference('sviw927mygd3')

      external_product_reference.must_be_instance_of(ExternalProductReference)
      external_product_reference.id.must_equal('sviw927mygd3')
      external_product_reference.reference_code.must_equal('abcde')
      external_product_reference.external_connection_type.must_equal('google_play_store')
      external_product_reference.created_at.must_equal(DateTime.new(2023, 5, 11, 22, 8, 14))
      external_product_reference.updated_at.must_equal(DateTime.new(2023, 5, 11, 22, 14, 11))
    end
  end
end

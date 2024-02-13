require 'spec_helper'

describe BusinessEntity do
  let(:revenue_gla) {
    GeneralLedgerAccount.new(
      account_type: 'revenue',
      code: '12345',
    )
  }
  let(:liablity_gla) {
    GeneralLedgerAccount.new(
      account_type: 'liability',
      code: '56789'
    )
  }
  let(:business_entity) {
    BusinessEntity.new(
      id: 'sokvpa93ztmm',
      code: 'samplecode',
      name: 'business_entity_name',
      invoice_display_address: Address.new({
        first_name: "P.",
        last_name: "Sherman",
        company: "Dentist Office",
        address1: "42 Wallaby Way",
        address2: "Suite 200",
        city: "Sydney",
        state: "New South Wales",
        country: "Australia",
        zip: "2060"
      }),
      tax_address: Address.new({
        first_name: "P.",
        last_name: "Sherman",
        company: "Dentist Office",
        address1: "42 Wallaby Way",
        address2: "Suite 200",
        city: "Sydney",
        state: "New South Wales",
        country: "Australia",
        zip: "2060"
      }),
      subscriber_location_countries: ['US', 'AU'],
      default_vat_number: '12345',
      default_registration_number: '12345',
      default_revenue_gl_account_id: revenue_gla.id,
      default_liability_gl_account_id: liablity_gla.id,
      created_at: '2023-05-23T19:02:40Z',
      updated_at: '2023-06-23T19:02:40Z'
    )
  }

  describe "#methods" do
    it "has correct attributes" do
      expect(business_entity.code).must_equal('samplecode')
      expect(business_entity.id).must_equal('sokvpa93ztmm')
      expect(business_entity.subscriber_location_countries).must_equal(['US', 'AU'])
      expect(business_entity.default_revenue_gl_account_id).must_equal(revenue_gla.id)
      expect(business_entity.default_liability_gl_account_id).must_equal(liablity_gla.id)
      expect(business_entity.created_at).must_equal('2023-05-23T19:02:40Z')
      expect(business_entity.updated_at).must_equal('2023-06-23T19:02:40Z')
    end
  end

  describe ".find" do
    let(:business_entity) {
      stub_api_request(:get, "business_entities/sbup2j0fx800", "business_entities/show-200")
      Recurly::BusinessEntity.find 'sbup2j0fx800'
    }

    it "returns a business entity" do
      business_entity.must_be_instance_of(BusinessEntity)
      business_entity.id.must_equal('sbup2j0fx800')
      business_entity.code.must_equal('default')
      business_entity.default_liability_gl_account_id.must_equal('12345')
      business_entity.default_revenue_gl_account_id.must_equal('56789')
    end
  end

  describe ".index" do
    let(:business_entities) {
      stub_api_request(:get, "business_entities", "business_entities/index-200")
      Recurly::BusinessEntity.all
    }

    it "returns all business entities" do
      expect(business_entities.count).must_equal(2)
    end
  end
end

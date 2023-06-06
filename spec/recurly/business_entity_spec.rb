require 'spec_helper'

describe BusinessEntity do
  let(:business_entity) {
    BusinessEntity.new(
      id: 'abc123',
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
      created_at: '2023-05-23T19:02:40Z',
      updated_at: '2023-06-23T19:02:40Z'
    )
  }

  describe "#associations" do
    it "has correct associations" do
      expect(business_entity).must_be_instance_of BusinessEntity
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(business_entity.code).must_equal('samplecode')
      expect(business_entity.id).must_equal('abc123')
      expect(business_entity.subscriber_location_countries).must_equal(['US', 'AU'])
      expect(business_entity.created_at).must_equal('2023-05-23T19:02:40Z')
      expect(business_entity.updated_at).must_equal('2023-06-23T19:02:40Z')
    end
  end
end
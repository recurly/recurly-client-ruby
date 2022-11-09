require 'spec_helper'

describe ExternalProduct do
  let(:external_product) {
    ExternalProduct.new(
      name: "external product 1", 
      created_at: "2022-11-06 17:08:18", 
      updated_at: "2022-11-06 17:08:18",
      plan: Plan.new(
        plan_code: 'plan_code 1',
        name: 'name 1',
      ),
      external_product_references: [
        ExternalProductReference.new(
          id: "abc123",
          reference_code: "reference_code 1",
          external_connection_type: "app store connect",
          created_at: "2019-08-24T14:15:22Z",
          updated_at: "2019-08-24T14:15:22Z"
        )
      ]
    )
  }

  describe 'serializing the record' do
    it 'serializes correctly' do
      external_product.to_xml.must_equal <<XML.chomp
<external_product>\
<created_at>2022-11-06 17:08:18</created_at>\
<external_product_references>\
<external_product_reference>\
<created_at>2019-08-24T14:15:22Z</created_at>\
<external_connection_type>app store connect</external_connection_type>\
<id>abc123</id>\
<reference_code>reference_code 1</reference_code>\
<updated_at>2019-08-24T14:15:22Z</updated_at>\
</external_product_reference>\
</external_product_references>\
<name>external product 1</name>\
<plan>\
<name>name 1</name>\
<plan_code>plan_code 1</plan_code>\
</plan>\
<updated_at>2022-11-06 17:08:18</updated_at>\
</external_product>
XML
    end
  end
end

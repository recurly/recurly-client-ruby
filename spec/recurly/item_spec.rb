require 'spec_helper'

describe Item do
  let(:item) do
    Item.new(
      item_code: 'pink_sweaters',
      name: 'Pink Sweaters',
      description: 'Some Pink Sweaters',
      external_sku: 'ABC-123',
      accounting_code: '1234',
      revenue_schedule_type: 'evenly',
      avalara_transaction_type: 600,
      avalara_service_type: 3
    )
  end

  it 'must serialize' do
    item.to_xml.must_equal <<XML.chomp
<item>\
<accounting_code>1234</accounting_code>\
<avalara_service_type>3</avalara_service_type>\
<avalara_transaction_type>600</avalara_transaction_type>\
<description>Some Pink Sweaters</description>\
<external_sku>ABC-123</external_sku>\
<item_code>pink_sweaters</item_code>\
<name>Pink Sweaters</name>\
<revenue_schedule_type>evenly</revenue_schedule_type>\
</item>
XML
  end

  describe "methods" do
    let(:item) { Item.find 'plastic_gloves' }

    describe ".find" do
      it "must return an item when available" do
        stub_api_request :get, 'items/plastic_gloves', 'items/show-200'

        item.must_be_instance_of Item
        item.description.must_equal 'Sleek Plastic'
      end
    end

    describe "#save" do
      before do
        @item = Item.new
      end

      it "must return true when new and valid" do
        stub_api_request :post, 'items', 'items/create-201'
        @item.save.must_equal true
        @item.description.must_equal 'Sleek Plastic'
      end
    end

    describe "update" do
      it "sends changed attributes to the server" do
        stub_api_request :get, 'items/plastic_gloves', 'items/show-200'
        stub_request(:put, "https://api.recurly.com/v2/items/plastic_gloves").
        with(:body => "<item><name>Sleek Plastic Gloves</name></item>",
          :headers => Recurly::API.headers).to_return(:status => 200, :body => "", :headers => {})
        item.update_attributes({ name: 'Sleek Plastic Gloves' })
      end
    end

    describe "delete" do
      it "must delete an existing item" do
        stub_api_request :get, 'items/plastic_gloves', 'items/show-200'
        stub_api_request(:delete, 'items/plastic_gloves') { XML[200][:destroy] }
        item.destroy.must_equal true
      end
    end

    describe "reactivate" do
      let (:inactive) {
        stub_api_request(:get, 'items/inactive', 'items/show-200-inactive')
        Item.find 'inactive'
      }

      it "must return true when deactivated account is reactivated" do
        stub_api_request(:put, 'items/plastic_gloves/reactivate', 'items/show-200')
        inactive.reactivate.must_equal true
      end
    end

    describe "custom fields" do
      it "should have a custom field" do
        stub_api_request :get, 'items/plastic_gloves', 'items/show-200'

        item.custom_fields.must_equal [CustomField.new(name: 'color', value: 'blue')]
      end

      it "should update custom fields" do
        stub_api_request :get, 'items/plastic_gloves', 'items/show-200'

        item.custom_fields.each do |custom_field|
          custom_field.value = "pink"
        end
        item.changed_attributes.has_key?("custom_fields").must_equal true
      end
    end
  end
end

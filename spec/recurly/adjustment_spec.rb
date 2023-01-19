require 'spec_helper'

describe Adjustment do
  describe ".find" do
    it "must return an adjustment when available" do
      stub_api_request(
        :get, 'adjustments/abcdef1234567890', 'adjustments/show-200'
      )
      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.must_be_instance_of Adjustment
      adjustment.type.must_equal 'charge'
      adjustment.quantity.must_equal 1
      adjustment.quantity_decimal.must_equal '1.2'
      adjustment.unit_amount_in_cents.to_i.must_equal 1200
      adjustment.discount_in_cents.to_i.must_equal 0
      adjustment.tax_in_cents.to_i.must_equal 5000
      adjustment.currency.must_equal 'USD'
      adjustment.tax_exempt?.must_equal false
      adjustment.tax_inclusive?.must_equal false
      adjustment.product_code.must_equal 'basic'
      adjustment.start_date.must_be_kind_of DateTime
      adjustment.end_date.must_be_kind_of DateTime
      adjustment.created_at.must_be_kind_of DateTime
      adjustment.tax_type.must_equal 'usst'
      adjustment.tax_region.must_equal 'CA'
      adjustment.tax_rate.must_equal 0.0875
      adjustment.revenue_schedule_type.must_equal 'evenly'
      adjustment.proration_rate.must_equal 0.5
      adjustment.surcharge_in_cents.must_equal 100
      adjustment.item_code.must_equal 'plastic_gloves'
      adjustment.external_sku.must_equal 'plastic_gloves'
      adjustment.avalara_service_type.must_equal 3
      adjustment.avalara_transaction_type.must_equal 600

      tax_details = adjustment.tax_details
      tax_details.length.must_equal 2
      state, county = tax_details

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

      adjustment.original_adjustment_uuid.must_equal 'abcdefg1234567'

      stub_api_request(:get, 'adjustments/abcdef1234567890', 'adjustments/show-200')
      adjustment.credit_adjustments.must_be_instance_of Resource::Pager
      adjustment.custom_fields.first.name.must_equal 'field1'
      adjustment.custom_fields.first.value.must_equal 'priceless'
    end

    it 'must return tax info when the site has it enabled' do
      stub_api_request(
        :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-taxed'
      )

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.tax_exempt?.must_equal false
    end

    it 'must parse the vertex details if available' do
      stub_api_request(
        :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-taxed'
      )

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.tax_types.length.must_equal 1

      tax_type = adjustment.tax_types.first
      tax_type.must_be_instance_of TaxType
      tax_type.type.must_equal 'General Sales and Use Tax'

      tax_type.juris_details.length.must_equal 3

      juris_detail = tax_type.juris_details.first
      juris_detail.classification.must_equal 'tax'
      juris_detail.jurisdiction.must_equal 'STATE'
      juris_detail.tax_in_cents[:USD].must_equal 115
      juris_detail.rate.must_equal 0.056
      juris_detail.description.must_equal 'Sales Tax'
      juris_detail.jurisdiction_name.must_equal nil
    end

    it "must raise an exception when unavailable" do
      stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-404'
      proc { Adjustment.find 'abcdef1234567890' }.must_raise Resource::NotFound
    end
  end

  describe "#subscription" do
    it "has a subscription if present" do
      stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-200'
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.subscription.must_be_instance_of Subscription
    end

    it "subscription is nil if not present" do
      stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-nosub'

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.subscription.must_equal nil
    end

    describe '#marshal_dump' do
      it 'must return the same instance variables' do
        stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-nosub'

        adjustment = Adjustment.find 'abcdef1234567890'
        adjustment_from_dump = Marshal.load(Marshal.dump(adjustment))

        adjustment.instance_variables.must_equal adjustment_from_dump.instance_variables
      end

      it 'must return the same values' do
        stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-nosub'

        adjustment = Adjustment.find 'abcdef1234567890'
        adjustment_from_dump = Marshal.load(Marshal.dump(adjustment))

        adjustment.type.must_equal adjustment_from_dump.type
      end
    end
  end

  describe '#bill_for_account' do
    it 'calls the account endpoint to fetch bill_for_account' do
      stub_api_request :get, 'adjustments/abcdef1234567890', 'adjustments/show-200'
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.bill_for_account.must_be_instance_of Account
    end
  end

  describe '#POST /accounts/{account_code}/adjustments' do
    let(:adjustment_body) do
      {
        unit_amount_in_cents:   5000,
        currency:               'USD',
        quantity:               1,
        accounting_code:        'bandwidth',
        tax_exempt:             false,
        custom_fields: [
          {
            name: 'field1',
            value: 'priceless'
          }
        ]
      }
    end
    let(:adjustment) { Adjustment.new(adjustment_body) }

    it 'must serialize' do
      adjustment.to_xml.must_equal <<XML.chomp
<adjustment>\
<accounting_code>bandwidth</accounting_code>\
<currency>USD</currency>\
<custom_fields>\
<custom_field>\
<name>field1</name>\
<value>priceless</value>\
</custom_field>\
</custom_fields>\
<quantity>1</quantity>\
<tax_exempt>false</tax_exempt>\
<unit_amount_in_cents>5000</unit_amount_in_cents>\
</adjustment>
XML
    end

    it 'creates an adjustment on the account specified' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      stub_api_request :post, 'accounts/abcdef1234567890/adjustments', 'adjustments/create-201'

      account = Account.find('abcdef1234567890')

      charge = account.adjustments.create(adjustment_body)
      charge.custom_fields.must_equal [CustomField.new(name: 'field1', value: 'priceless')]
    end
  end
end

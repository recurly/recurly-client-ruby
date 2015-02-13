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
      adjustment.unit_amount_in_cents.to_i.must_equal 1200
      adjustment.discount_in_cents.to_i.must_equal 0
      adjustment.tax_in_cents.to_i.must_equal 5000
      adjustment.currency.must_equal 'USD'
      adjustment.tax_exempt?.must_equal false
      adjustment.product_code.must_equal 'basic'
      adjustment.start_date.must_be_kind_of DateTime
      adjustment.end_date.must_be_kind_of DateTime
      adjustment.created_at.must_be_kind_of DateTime
      adjustment.tax_type.must_equal 'usst'
      adjustment.tax_region.must_equal 'CA'
      adjustment.tax_rate.must_equal 0.0875

      tax_details = adjustment.tax_details
      tax_details.length.must_equal 2
      state, county = tax_details

      state.name.must_equal 'california'
      state.type.must_equal 'state'
      state.tax_rate.must_equal 0.065
      state.tax_in_cents.to_i.must_equal 3000

      county.name.must_equal 'san francisco'
      county.type.must_equal 'county'
      county.tax_rate.must_equal 0.02
      county.tax_in_cents.to_i.must_equal 2000
    end

    it 'must return tax info when the site has it enabled' do
      stub_api_request(
        :get, 'adjustments/abcdef1234567890', 'adjustments/show-200-taxed'
      )

      adjustment = Adjustment.find 'abcdef1234567890'
      adjustment.tax_exempt?.must_equal false
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
  end
end

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
      adjustment.tax_in_cents.to_i.must_equal 0
      adjustment.currency.must_equal 'USD'
      adjustment.taxable?.must_equal false
      adjustment.product_code.must_equal 'basic'
      adjustment.start_date.must_be_kind_of DateTime
      adjustment.end_date.must_be_kind_of DateTime
      adjustment.created_at.must_be_kind_of DateTime
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

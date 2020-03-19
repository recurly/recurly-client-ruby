require 'spec_helper'

describe AddOn do
  before do
    stub_api_request(
      :get, 'plans/gold', 'plans/show-200'
    )
    stub_api_request(
      :get, 'plans/plantfile', 'plans/show-200-tiered'
    )
    stub_api_request(
      :get, 'plans/gold/add_ons', 'plans/add_ons/index-200'
    )
    stub_api_request(
      :get, 'plans/plantfile/add_ons', 'plans/add_ons/index-200-tiered'
    )
  end

  describe ".find" do
    it "must return an addon when available" do
      plan = Plan.find 'gold'
      add_ons = plan.add_ons

      add_ons.length.must_equal 1

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
    end

    it "must return an addon with tiered-pricing when available" do
      plan = Plan.find 'plantfile'
      add_ons = plan.add_ons

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.tier_type.must_equal "tiered"
    end
  end
end

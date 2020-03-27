require 'spec_helper'

describe AddOn do
  before do
    stub_api_request(
      :get, 'plans/gold', 'plans/show-200'
    )
    stub_api_request(
      :get, 'plans/gold/add_ons', 'plans/add_ons/index-200'
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
  end
end

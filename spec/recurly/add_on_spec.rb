require 'spec_helper'

describe AddOn do
  before do
    stub_api_request(
      :get, 'plans/gold', 'plans/show-200'
    )
    stub_api_request(
      :get, 'plans/gold/add_ons', 'plans/add_ons/index-200'
    )
    stub_api_request(
      :get, 'plans/orchidreset', 'plans/show-200-item-backed'
    )
    stub_api_request(
      :get, 'plans/orchidreset/add_ons', 'plans/item_backed_add_ons/index-200'
    )
    stub_api_request(
      :get, 'plans/plantfile', 'plans/show-200-tiered'
    )
    stub_api_request(
      :get, 'plans/percentageplan', 'plans/show-200-tiered-percentage'
    )
    stub_api_request(
      :get, 'plans/plantfile/add_ons', 'plans/add_ons/index-200-tiered'
    )
    stub_api_request(
      :get, 'plans/percentageplan/add_ons', 'plans/add_ons/index-200-tiered-percentage'
    )
  end

  describe ".find" do
    it "must return an add-on when available" do
      plan = Plan.find 'gold'
      add_ons = plan.add_ons

      add_ons.length.must_equal 1

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.add_on_code.must_equal "marketing_email"
    end

    it "must return avalara types available" do
      plan = Plan.find 'gold'
      add_ons = plan.add_ons

      add_ons.length.must_equal 1

      add_on = add_ons.first
      add_on.avalara_service_type.must_equal 600
      add_on.avalara_transaction_type.must_equal 3
    end

    it "must return an item-backed add-on when available" do
      plan = Plan.find 'orchidreset'
      add_ons = plan.add_ons

      add_ons.length.must_equal 1

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.add_on_code.must_equal "marfa_brunch"
    end

    it "must return an addon with tiered-pricing when available" do
      plan = Plan.find 'plantfile'
      add_ons = plan.add_ons

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.tier_type.must_equal "tiered"
    end

    it "must return an addon with percentage-tiered-pricing and usage_timeframe when available" do
      plan = Plan.find 'percentageplan'
      add_ons = plan.add_ons

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.tier_type.must_equal "tiered"
      add_on.usage_type.must_equal "percentage"
      add_on.usage_timeframe.must_equal "billing_period"
      add_on.percentage_tiers.count.must_equal 2
      add_on.percentage_tiers.first.must_be_instance_of CurrencyPercentageTier
      add_on.percentage_tiers.first.tiers.count.must_equal 2
      add_on.percentage_tiers.first.tiers.first.must_be_instance_of PercentageTier
    end
  end
end

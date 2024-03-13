require 'spec_helper'

describe AddOn do
  let(:add_on) do
    AddOn.new(
      add_on_code:                'pink_sweaters',
      name:                       'Pink Sweaters',
      revenue_schedule_type:      'evenly',
      unit_amount_in_cents:       200,
      add_on_type:                'usage',
      optional:                   false,
      usage_type:                 'price',
      liability_gl_account_id:    'uf0jwj5zhclg',
      revenue_gl_account_id:      'uf0jwincednb',
      performance_obligation_id:   '1',
    )
  end

  it 'must serialize' do
    add_on.to_xml.must_equal <<XML.chomp
<add_on>\
<add_on_code>pink_sweaters</add_on_code>\
<add_on_type>usage</add_on_type>\
<liability_gl_account_id>uf0jwj5zhclg</liability_gl_account_id>\
<name>Pink Sweaters</name>\
<optional>false</optional>\
<performance_obligation_id>1</performance_obligation_id>\
<revenue_gl_account_id>uf0jwincednb</revenue_gl_account_id>\
<revenue_schedule_type>evenly</revenue_schedule_type>\
<unit_amount_in_cents>\
<USD>200</USD>\
</unit_amount_in_cents>\
<usage_type>price</usage_type>\
</add_on>
XML
  end

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
    stub_api_request(
      :get, 'plans/gold/add_ons/marketing_email', 'plans/add_ons/show-200'
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

    it "returns RevRec attributes" do
      plan = Plan.find 'gold'
      add_ons = plan.add_ons

      add_on = add_ons.first
      add_on.must_be_instance_of AddOn
      add_on.liability_gl_account_id.must_equal "udexyr9hjgkc"
      add_on.revenue_gl_account_id.must_equal "uelq7rzkydlu"
      add_on.performance_obligation_id.must_equal "6"
    end
  end

  describe "create" do
    it "must create a new add-on" do
      stub_request(:post, "https://api.recurly.com/v2/plans/gold/add_ons").
        with(:body => "<add_on><add_on_code>pink_sweaters</add_on_code><add_on_type>usage</add_on_type><liability_gl_account_id>uf0jwj5zhclg</liability_gl_account_id><name>Pink Sweaters</name><optional>false</optional><performance_obligation_id>1</performance_obligation_id><revenue_gl_account_id>uf0jwincednb</revenue_gl_account_id><revenue_schedule_type>evenly</revenue_schedule_type><unit_amount_in_cents><USD>200</USD></unit_amount_in_cents><usage_type>price</usage_type></add_on>",
             :headers => Recurly::API.headers).to_return(:status => 200, :body => "", :headers => {})

      plan = Plan.find 'gold'
      add_on = plan.add_ons.create(
        add_on_code: 'pink_sweaters',
        name: 'Pink Sweaters',
        revenue_schedule_type: 'evenly',
        unit_amount_in_cents: 200,
        add_on_type: 'usage',
        optional: false,
        usage_type: 'price',
        liability_gl_account_id: 'uf0jwj5zhclg',
        revenue_gl_account_id: 'uf0jwincednb',
        performance_obligation_id: '1'
      )
      add_on.must_be_instance_of AddOn
      add_on.name.must_equal 'Pink Sweaters'
    end
  end

  describe "update" do
    it "sends changed attributes to the server" do
      plan = Plan.find 'gold'
      add_on = plan.add_ons.find 'marketing_email'
      stub_request(:put, "https://api.recurly.com/v2/plans/gold/add_ons/marketing_email").
      with(:body => "<add_on><liability_gl_account_id>a8hkyaw9nm</liability_gl_account_id><name>Updated Emails</name><revenue_gl_account_id>aksdfu48</revenue_gl_account_id></add_on>",
        :headers => Recurly::API.headers).to_return(:status => 200, :body => "", :headers => {})
      add_on.update_attributes({ name: 'Updated Emails', revenue_gl_account_id: 'aksdfu48',
                                 liability_gl_account_id: 'a8hkyaw9nm', performance_obligation_id: '6'})
    end
  end
end

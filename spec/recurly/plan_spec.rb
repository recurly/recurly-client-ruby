require 'spec_helper'

describe Plan do
  let(:plan) {
    Plan.new(
      :plan_code                 => "gold",
      :name                      => "The Gold Plan",
      :unit_amount_in_cents      => 79_00,
      :description               => "The Gold Plan is for folks who love gold.",
      :accounting_code           => "gold_plan_acc_code",
      :setup_fee_accounting_code => "setup_fee_ac",
      :setup_fee_in_cents        => 60_00,
      :plan_interval_length      => 1,
      :plan_interval_unit        => 'months',
      :tax_exempt                => false,
      :revenue_schedule_type     => 'evenly'
    )
  }

  it 'must serialize' do
    plan.to_xml.must_equal <<XML.chomp
<plan>\
<accounting_code>gold_plan_acc_code</accounting_code>\
<description>The Gold Plan is for folks who love gold.</description>\
<name>The Gold Plan</name>\
<plan_code>gold</plan_code>\
<plan_interval_length>1</plan_interval_length>\
<plan_interval_unit>months</plan_interval_unit>\
<revenue_schedule_type>evenly</revenue_schedule_type>\
<setup_fee_accounting_code>setup_fee_ac</setup_fee_accounting_code>\
<setup_fee_in_cents>\
<USD>6000</USD>\
</setup_fee_in_cents>\
<tax_exempt>false</tax_exempt>\
<unit_amount_in_cents>\
<USD>7900</USD>\
</unit_amount_in_cents>\
</plan>
XML
  end

  describe ".find" do
    it "must return a plan when available" do
      stub_api_request(
        :get, 'plans/gold', 'plans/show-200'
      )
      plan = Plan.find 'gold'
      plan.must_be_instance_of Plan
    end
  end
end

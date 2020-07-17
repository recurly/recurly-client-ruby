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
      :revenue_schedule_type     => 'evenly',
      :avalara_transaction_type  => 600,
      :avalara_service_type      => 3,
    )
  }

  it 'must serialize' do
    plan.to_xml.must_equal <<XML.chomp
<plan>\
<accounting_code>gold_plan_acc_code</accounting_code>\
<avalara_service_type>3</avalara_service_type>\
<avalara_transaction_type>600</avalara_transaction_type>\
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

  describe ".save!" do
    it "must raise an Invalid error when currency is not enabled on the site" do
      stub_api_request :get, 'plans/gold', 'plans/show-200'
      stub_api_request :put, 'plans/gold', 'plans/show-422'

      plan = Plan.find 'gold'
      plan.unit_amount_in_cents['BRL'] = 329_00
      proc{plan.save!}.must_raise Resource::Invalid

      plan.errors['unit_amount_in_cents'].must_equal ["is invalid"]
      plan.errors['setup_fee_in_cents'].must_equal ["is invalid"]
    end
  end
end

require 'spec_helper'

describe Plan do
  let(:plan) {
    Plan.new(
      :plan_code                              => 'gold',
      :name                                   => 'The Gold Plan',
      :unit_amount_in_cents                   => 79_00,
      :description                            => 'The Gold Plan is for folks who love gold.',
      :accounting_code                        => 'gold_plan_acc_code',
      :setup_fee_accounting_code              => 'setup_fee_ac',
      :setup_fee_in_cents                     => 60_00,
      :plan_interval_length                   => 1,
      :plan_interval_unit                     => 'months',
      :pricing_model                          => 'fixed',
      :tax_exempt                             => false,
      :revenue_schedule_type                  => 'evenly',
      :avalara_transaction_type               => 600,
      :avalara_service_type                   => 3,
      :custom_fields                          => [{ :name => 'color', value: 'Red' }],
    )
  }

  describe 'when pricing_model is fixed' do
    let(:expected_xml) do
      <<~XML.gsub('  ', '').chomp
        <plan>\
          <accounting_code>gold_plan_acc_code</accounting_code>\
          <avalara_service_type>3</avalara_service_type>\
          <avalara_transaction_type>600</avalara_transaction_type>\
          <custom_fields>\
            <custom_field>\
              <name>color</name>\
              <value>Red</value>\
            </custom_field>\
          </custom_fields>\
          <description>The Gold Plan is for folks who love gold.</description>\
          <name>The Gold Plan</name>\
          <plan_code>gold</plan_code>\
          <plan_interval_length>1</plan_interval_length>\
          <plan_interval_unit>months</plan_interval_unit>\
          <pricing_model>fixed</pricing_model>\
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
    it 'must serialize' do
      plan.to_xml.must_equal expected_xml
    end
  end

  describe 'when pricing_model is ramp' do
    let(:expected_xml) do
      <<~XML.gsub('  ', '').chomp
        <plan>\
          <accounting_code>gold_plan_acc_code</accounting_code>\
          <avalara_service_type>3</avalara_service_type>\
          <avalara_transaction_type>600</avalara_transaction_type>\
          <custom_fields>\
            <custom_field>\
              <name>color</name>\
              <value>Red</value>\
            </custom_field>\
          </custom_fields>\
          <description>The Gold Plan is for folks who love gold.</description>\
          <name>The Gold Plan</name>\
          <plan_code>gold</plan_code>\
          <plan_interval_length>1</plan_interval_length>\
          <plan_interval_unit>months</plan_interval_unit>\
          <pricing_model>ramp</pricing_model>\
          <ramp_intervals>\
            <ramp_interval>\
              <starting_billing_cycle>1</starting_billing_cycle>\
              <unit_amount_in_cents>\
                <USD>1000</USD>\
              </unit_amount_in_cents>\
            </ramp_interval>\
            <ramp_interval>\
              <starting_billing_cycle>2</starting_billing_cycle>\
              <unit_amount_in_cents>\
                <USD>2000</USD>\
              </unit_amount_in_cents>\
            </ramp_interval>\
          </ramp_intervals>\
          <revenue_schedule_type>evenly</revenue_schedule_type>\
          <setup_fee_accounting_code>setup_fee_ac</setup_fee_accounting_code>\
          <setup_fee_in_cents>\
            <USD>6000</USD>\
          </setup_fee_in_cents>\
          <tax_exempt>false</tax_exempt>\
        </plan>
      XML
    end

    before do
      plan.pricing_model = 'ramp'
      plan.unit_amount_in_cents = nil
      plan.ramp_intervals = [
        Recurly::PlanRampInterval.new(
          starting_billing_cycle: 1,
          unit_amount_in_cents: {
            USD: 1000
          }
        ),
        Recurly::PlanRampInterval.new(
          starting_billing_cycle: 2,
          unit_amount_in_cents: {
            USD: 2000
          }
        )
      ]
    end

    it 'must serialize' do
      plan.to_xml.must_equal expected_xml
    end
  end

  describe '.find' do
    before do
      stub_api_request(:get, 'plans/gold', 'plans/show-200')
    end
    let(:plan) { Plan.find 'gold' }

    it 'returns a plan when available' do
      plan.must_be_instance_of Plan
      plan.plan_code.must_equal('gold')
    end

    it 'returns plan with the custom fields' do
      plan.custom_fields[0].name.must_equal('color')
      plan.custom_fields[0].value.must_equal('Red')
    end

    it 'returns RevRec attributes' do
      plan.setup_fee_performance_obligation_id.must_equal('4')
      plan.performance_obligation_id.must_equal('6')
      plan.setup_fee_liability_gl_account_id.must_equal('udf6ktwsed99')
      plan.liability_gl_account_id.must_equal('udf6kuqq5rwr')
      plan.setup_fee_revenue_gl_account_id.must_equal('udf6ktdh636s')
      plan.revenue_gl_account_id.must_equal('udf6kubl7urs')
    end
  end

  describe 'RevRec attributes' do
    let(:plan) {
      Plan.new(
        :plan_code                              => 'gold',
        :name                                   => 'The Gold Plan',
        :unit_amount_in_cents                   => 79_00,
        :description                            => 'The Gold Plan is for folks who love gold.',
        :setup_fee_in_cents                     => 60_00,
        :plan_interval_length                   => 1,
        :plan_interval_unit                     => 'months',
        :pricing_model                          => 'fixed',
        :setup_fee_performance_obligation_id    => '1',
        :performance_obligation_id              => '7uf',
        :revenue_gl_account_id                  => '6t5',
        :liability_gl_account_id                => '8y7',
      )
    }

    let(:expected_xml) do
      <<~XML.gsub('  ', '').chomp
        <plan>\
          <description>The Gold Plan is for folks who love gold.</description>\
          <liability_gl_account_id>8y7</liability_gl_account_id>\
          <name>The Gold Plan</name>\
          <performance_obligation_id>7uf</performance_obligation_id>\
          <plan_code>gold</plan_code>\
          <plan_interval_length>1</plan_interval_length>\
          <plan_interval_unit>months</plan_interval_unit>\
          <pricing_model>fixed</pricing_model>\
          <revenue_gl_account_id>6t5</revenue_gl_account_id>\
          <setup_fee_in_cents>\
            <USD>6000</USD>\
          </setup_fee_in_cents>\
          <setup_fee_performance_obligation_id>1</setup_fee_performance_obligation_id>\
          <unit_amount_in_cents>\
            <USD>7900</USD>\
          </unit_amount_in_cents>\
        </plan>
      XML
    end

    it 'must serialize' do
      plan.to_xml.must_equal expected_xml
    end
  end

  describe '.save!' do
    before do
      stub_api_request :get, 'plans/gold', 'plans/show-200'
      stub_api_request :put, 'plans/gold', 'plans/show-422'
    end

    it 'must raise an Invalid error when currency is not enabled on the site' do
      plan = Plan.find 'gold'
      plan.unit_amount_in_cents['BRL'] = 329_00
      proc{plan.save!}.must_raise Resource::Invalid

      plan.errors['unit_amount_in_cents'].must_equal ['is invalid']
      plan.errors['setup_fee_in_cents'].must_equal ['is invalid']
    end
  end
end
require 'spec_helper'

describe Plan do
  let(:plan) {
    Plan.new(
      :plan_code            => "gold",
      :name                 => "The Gold Plan",
      :unit_amount_in_cents => 79_00
    )
  }

  it 'must serialize' do
    plan.to_xml.must_equal <<XML.chomp
<plan>\
<name>The Gold Plan</name>\
<plan_code>gold</plan_code>\
<unit_amount_in_cents><USD>7900</USD></unit_amount_in_cents>\
</plan>
XML
  end
end

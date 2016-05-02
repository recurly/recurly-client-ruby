require 'spec_helper'

describe MeasuredUnit do
  describe ".find" do
    it "must return a measured_unit when available" do
      stub_api_request(
        :get, 'measured_units/384510339510699803', 'measured_units/show-200'
      )
      measured_unit = MeasuredUnit.find '384510339510699803'
      measured_unit.must_be_instance_of MeasuredUnit
    end
  end
end

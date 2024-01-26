require 'spec_helper'

describe PerformanceObligation do
  let(:performance_obligation) {
    stub_api_request(:get, "performance_obligations/6", "performance_obligations/show-200")
    Recurly::PerformanceObligation.find '6'
  }

  let(:performance_obligations) {
    stub_api_request(:get, "performance_obligations", "performance_obligations/index-200")
    Recurly::PerformanceObligation.all
  }

  describe "#find" do
    it "returns a PerformanceObligation" do
      performance_obligation.must_be_instance_of(PerformanceObligation)
    end

    it "has correct attributes" do
      expect(performance_obligation.id).must_equal('6')
      expect(performance_obligation.name).must_equal('Over Time (Daily)')
      expect(performance_obligation.created_at).wont_be_nil
    end
  end

  describe "#index" do
    describe "when no params are passed" do
      it "returns a list of performance obligations" do
        expect(performance_obligations.count).must_equal(3)
      end
    end
  end
end
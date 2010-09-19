require 'spec_helper'

module Recurly
  describe Plan do

    describe "list all plans" do
      around(:each){|e| VCR.use_cassette('plan/all', &e)}

      before(:each) do
        @paid = Factory.paid_plan
        @trial = Factory.trial_plan
        @plans = Plan.all
      end

      it "should return a list result" do
        @plans.should be_an_instance_of(Array)
      end

      it "should return the paid plan" do
        @plans.should include(@paid)
      end

      it "should return the trial plan" do
        @plans.should include(@trial)
      end

    end

    describe "find plan" do
      around(:each){|e| VCR.use_cassette('plan/find', &e)}
      before(:each) do
        @paid = Factory.paid_plan
        @trial = Factory.trial_plan
      end

      it "should return the paid plan" do
        plan = Plan.find(@paid.plan_code)
        plan.should_not be_nil
        plan.should == @paid
      end

      it "should return the trial plan" do
        plan = Plan.find(@trial.plan_code)
        plan.should_not be_nil
        plan.should == @trial
      end
    end

    describe "update a plan" do
      around(:each){|e| VCR.use_cassette('plan/update', &e)}

      # grabs a fresh test_plan
      def test_plan
        Plan.find("test")
      end

      before(:each) do

        begin
          @test_plan = test_plan
        rescue ActiveResource::ResourceNotFound => e
          Plan.new({
            :plan_code => "test",
            :name => "Test Plan",
            :unit_amount_in_cents => 100,
            :plan_interval_length => 1,
            :plan_interval_unit => "months",
            :trial_interval_length => 0,
            :trial_interval_unit => "months"
          }).save!
          @test_plan = test_plan
        end

        # double the price
        @test_plan.unit_amount_in_cents = 200
        @test_plan.save!
      end

      it "should update the plan" do
        @test_plan = test_plan
        @test_plan.unit_amount_in_cents.should == 200
      end
    end

  end
end
require 'spec_helper'

module Recurly
  describe Plan do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "list all plans" do
      use_vcr_cassette "plan/all"

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
      use_vcr_cassette 'plan/find'
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
      use_vcr_cassette 'plan/update'

      # grabs a fresh test_plan
      def test_plan
        Plan.find("test")
      end

      # setup test plan
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
      end

      it "should update the plan" do
        @test_plan.unit_amount_in_cents = 200
        @test_plan.save!

        @test_plan = test_plan
        @test_plan.unit_amount_in_cents.should == 200
      end
    end

    describe "delete a plan" do
      use_vcr_cassette "plan/delete/#{timestamp}"

      let(:plan) do
        plan = Plan.new({
          :plan_code => "test_#{timestamp}",
          :name => "Test Plan #{timestamp}",
          :unit_amount_in_cents => 100,
          :plan_interval_length => 1,
          :plan_interval_unit => "months",
          :trial_interval_length => 0,
          :trial_interval_unit => "months"
        })
        plan.save!
        plan
      end

      it "should delete the plan" do
        @plan = Plan.find(plan.plan_code)
        @plan.destroy

        expect {
          Plan.find(@plan.plan_code)
        }.to raise_error(ActiveResource::ResourceNotFound)
      end

    end

  end
end
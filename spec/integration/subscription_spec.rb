require 'spec_helper'

module Recurly
  describe Subscription do

    around(:each) do |example|
      VCR.use_cassette('subscription', :record => :new_episodes, &example)
    end

    describe "#create" do
      let(:account){ Factory.create_account("new-sub-new-account") }

      before(:each) do
        @subscription = Factory.create_subscription(account)
      end

      it "should create the subscription successfully" do
        @subscription.should_not be_nil
      end

      it "should not be canceled" do
        @subscription.canceled_at.should be_nil
      end

      it "should be active" do
        @subscription.state.should == "active"
      end

      it "should be started" do
        @subscription.current_period_started_at.should_not be_nil
      end
    end

    describe "#update" do
      let(:account){ Factory.create_account("update-subscription") }

      before(:each) do
        Factory.create_subscription(account)
        @subscription = Subscription.find(account.account_code)

        @subscription.change('now', :quantity => 2)
      end

      it "should update the subscription quanity" do
        Subscription.find(account.account_code).quantity.should == 2
      end
    end

    describe "#cancel" do
      let(:account){ Factory.create_account("cancel-subscription") }
      before(:each) do
        Factory.create_subscription(account)
        @subscription = Subscription.find(account.account_code)

        # cancel subscription
        @subscription.cancel(account.account_code)
      end

      it "should mark the subscription state as canceled" do
        Subscription.find(account.account_code).state.should == "canceled"
      end

      it "should mark the subscription canceled_at" do
        Subscription.find(account.account_code).canceled_at.should_not be_nil
      end
    end

    describe "#refund" do
      let(:account){ Factory.create_account("refund-subscription") }

      before(:each) do
        Factory.create_subscription(account)
        @subscription = Subscription.find(account.account_code)

        @subscription.refund(:full)
      end

      it "should remove the subscription entry" do
        expects {
          Subscription.find(account.account_code)
        }.to raise_error(ActiveResource::ResourceNotFound)
      end

    end

  end
end
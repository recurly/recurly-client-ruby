require 'spec_helper'

module Recurly
  describe Subscription do

    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette('subscription/create', &example)
      end

      let(:account){ Factory.create_account("subscription-create") }

      before(:each) do
        @subscription = Factory.create_subscription(account, :trial)
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
      around(:each) do |example|
        VCR.use_cassette('subscription/update', &example)
      end

      let(:account){ Factory.create_account("subscription-update") }

      before(:each) do
        Factory.create_subscription(account, :trial)
        @subscription = Subscription.find(account.account_code)

        @subscription.change('now', :quantity => 2)
      end

      it "should update the subscription quantity" do
        Subscription.find(account.account_code).quantity.should == 2
      end
    end

    describe "#cancel" do
      around(:each) do |example|
        VCR.use_cassette('subscription/cancel', &example)
      end

      let(:account){ Factory.create_account("subscription-cancel") }
      before(:each) do
        Factory.create_subscription(account, :trial)
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
      around(:each) do |example|
        VCR.use_cassette('subscription/refund', &example)
      end

      let(:account){ Factory.create_account("subscription-refund") }

      before(:each) do
        Factory.create_subscription(account, :trial)
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
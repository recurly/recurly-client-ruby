require 'spec_helper'

module Recurly
  describe Subscription do

    describe "#create" do
      around(:each){|e| VCR.use_cassette('subscription/create', &e)}

      let(:account){ Factory.create_account("subscription-create") }

      before(:each) do
        @subscription = Factory.create_subscription(account, :paid)
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
      around(:each){|e| VCR.use_cassette('subscription/update', &e)}

      let(:account){ Factory.create_account("subscription-update") }

      before(:each) do
        Factory.create_subscription(account, :paid)
        @subscription = Subscription.find(account.account_code)

        @subscription.change('now', :quantity => 2)
      end

      it "should update the subscription quantity" do
        Subscription.find(account.account_code).quantity.should == 2
      end
    end

    describe "#cancel" do
      around(:each){|e| VCR.use_cassette('subscription/cancel', &e)}

      let(:account){ Factory.create_account("subscription-cancel") }
      before(:each) do
        Factory.create_subscription(account, :paid)
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
      around(:each){|e| VCR.use_cassette('subscription/refund', &e)}

      let(:account){ Factory.create_account("subscription-refund") }

      before(:each) do
        Factory.create_subscription(account, :paid)
        @subscription = Subscription.find(account.account_code)
      end

      it "should remove the subscription entry" do
        @subscription.refund(:full)
        expect {
          Subscription.find(account.account_code)
        }.to raise_error(ActiveResource::ResourceNotFound)
      end

    end

  end
end
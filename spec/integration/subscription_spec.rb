require 'spec_helper'

require 'test/unit'
require 'active_support/testing/deprecation'

module Recurly
  describe Subscription do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "look up a subscription" do
      use_vcr_cassette "subscription/find/#{timestamp}"

      let(:account){ Factory.create_account("subscription-find-#{timestamp}") }

      before(:each) do
        Factory.create_subscription(account, :paid)
      end

      it "should return the subscription" do
        subscription = Subscription.find(account.account_code)
        subscription.state.should == "active"
        subscription.plan.plan_code.should == "paid"
      end
    end

    describe "create a new subscription" do
      use_vcr_cassette "subscription/create/#{timestamp}"

      let(:account){ Factory.create_account("subscription-create-#{timestamp}") }

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

    describe "updates and downgrades" do

      context "normal case" do
        use_vcr_cassette "subscription/change1/#{timestamp}"

        let(:account){ Factory.create_account("subscription-change1-#{timestamp}") }

        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)

          @subscription.change('now', :quantity => 2)
        end

        it "should update the subscription quantity" do
          Subscription.find(account.account_code).quantity.should == 2
        end
      end

      context "when account code is an integer (issue GH-4)" do
        use_vcr_cassette "subscription/change2/#{timestamp}"

        let(:account){ Factory.create_account(timestamp) }

        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)

          @subscription.id = account.account_code.to_i
          @subscription.change('now', :quantity => 2)
        end

        it "should update the subscription quantity" do
          Subscription.find(account.account_code).quantity.should == 2
        end
      end
    end

    describe "reactivate a subscription" do
      use_vcr_cassette "subscription/reactivate/#{timestamp}"

      let(:account){ Factory.create_account("subscription-reactivate-#{timestamp}") }
      before(:each) do
        Factory.create_subscription(account, :paid)
        @subscription = Subscription.find(account.account_code)
        @subscription.cancel

        Subscription.reactivate(account.account_code)
      end

      it "should mark the subscription as active" do
        subscription = Subscription.find(account.account_code)
        subscription.state.should == "active"
      end

    end

    describe "cancel a subscription" do
      context "without account_code" do

        use_vcr_cassette "subscription/cancel/#{timestamp}"

        let(:account){ Factory.create_account("subscription-cancel-#{timestamp}") }
        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)

          # cancel subscription
          @subscription.cancel
        end

        it "should mark the subscription state as canceled" do
          Subscription.find(account.account_code).state.should == "canceled"
        end

        it "should mark the subscription canceled_at" do
          Subscription.find(account.account_code).canceled_at.should_not be_nil
        end

      end

      context "with account_code (backward compat)" do
        use_vcr_cassette "subscription/cancel-with-code/#{timestamp}"

        include ActiveSupport::Testing::Deprecation

        # ghetto workaround for rspec2 (till i figure out how to use test/unit helpers within rspec)
        def assert(value, msg = nil)
          raise "#{value} should have been true" unless value
        end

        let(:account){ Factory.create_account("subscription-cancel-with-code-#{timestamp}") }
        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)

          assert_deprecated("Calling Recurly::Subscription#cancel with an account_code has been deprecated. Use the static method Recurly::Subscription.cancel(account_code) instead") do
            # cancel subscription
            @subscription.cancel(account.account_code)
          end
        end

        it "should mark the subscription state as canceled" do
          Subscription.find(account.account_code).state.should == "canceled"
          Subscription.find(account.account_code).canceled_at.should_not be_nil
        end
      end
    end

    describe "refund a subscription" do
      context "full refund" do
        use_vcr_cassette "subscription/refund-full/#{timestamp}"

        let(:account){ Factory.create_account("subscription-refund-full-#{timestamp}") }

        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)
        end

        it "should remove the subscription entry and post a full refund" do
          @subscription.refund(:full)
          expect {
            Subscription.find(account.account_code)
          }.to raise_error(ActiveResource::ResourceNotFound)
        end
      end

      context "partial refund" do
        use_vcr_cassette "subscription/refund-partial/#{timestamp}"

        let(:account){ Factory.create_account("subscription-refund-partial-#{timestamp}") }

        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)
        end

        it "should remove the subscription entry and post a partial refund" do
          @subscription.refund(:partial)
          expect {
            Subscription.find(account.account_code)
          }.to raise_error(ActiveResource::ResourceNotFound)
        end
      end

      context "no refund" do
        use_vcr_cassette "subscription/refund-none/#{timestamp}"

        let(:account){ Factory.create_account("subscription-refund-none-#{timestamp}") }

        before(:each) do
          Factory.create_subscription(account, :paid)
          @subscription = Subscription.find(account.account_code)
        end

        it "should remove the subscription entry and not post a refund" do
          @subscription.refund(:none)
          expect {
            Subscription.find(account.account_code)
          }.to raise_error(ActiveResource::ResourceNotFound)
        end
      end

    end
  end
end
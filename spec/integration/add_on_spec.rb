require 'spec_helper'

module Recurly
  describe "Subscription Addons" do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "create a subscription with addons" do
      use_vcr_cassette "subscription/addons/create/#{timestamp}"

      let(:account){ Factory.create_account("subscription-addons-create-#{timestamp}") }

      before(:each) do
        Factory.create_subscription(account, :paid, :add_ons => [
          {
            :add_on_code => "special",
            :quantity => 1,
            :unit_amount => 10,
          }
        ])
      end

      it "should return the subscription addons" do
        subscription = Subscription.find(account.account_code)
        subscription.add_ons.count == 1
      end
    end

    describe "add an addon to a subscription" do
      use_vcr_cassette "subscription/addons/add/#{timestamp}"

      let(:account){ Factory.create_account("subscription-addons-add-#{timestamp}") }

      before(:each) do
        Factory.create_subscription(account, :paid, :add_ons => [
          {
            :add_on_code => "special",
            :quantity => 1,
            :unit_amount => 10,
          }
        ])
      end

      it "should allow adding a new addon" do
        subscription = Subscription.find(account.account_code)
        subscription.add_ons << {
          :add_on_code => "special2",
          :quantity => 2,
          :unit_amount => 500
        }
        subscription.change('now', :add_ons => subscription.add_ons)

        subscription = Subscription.find(account.account_code)
        subscription.add_ons.count == 2
      end
    end

    describe "remove an addon from a subscription" do
      use_vcr_cassette "subscription/addons/remove/#{timestamp}"

      let(:account){ Factory.create_account("subscription-addons-remove-#{timestamp}") }

      before(:each) do
        Factory.create_subscription(account, :paid, :add_ons => [
          {
            :add_on_code => "special",
            :quantity => 1,
            :unit_amount => 1000,
          }
        ])
      end

      it "should allow removing an addon" do
        subscription = Subscription.find(account.account_code)
        subscription.change('now', :add_ons => [])

        subscription = Subscription.find(account.account_code)
        subscription.add_ons.count == 0
      end

    end

  end
end

require 'spec_helper'

describe Subscription do
  describe "attributes" do
    subject { Subscription }

    it "has all expected attributes" do
      expected_attributes = %w{ uuid
                                state
                                unit_amount_in_cents
                                currency
                                quantity
                                activated_at
                                canceled_at
                                expires_at
                                current_period_started_at
                                current_period_ends_at
                                trial_started_at
                                trial_ends_at
                                pending_subscription
                                subscription_add_ons
                                coupon_code
                                total_billing_cycles}

        subject.attribute_names.sort.must_equal expected_attributes.sort
      end
  end

  describe "add-ons" do
    it "must assign via symbol array" do
      subscription = Subscription.new :add_ons => [:trial]
      subscription.add_ons.must_equal(
        Subscription::AddOns.new(subscription, [:trial])
      )
    end

    it "must assign via hash array" do
      subscription = Subscription.new :add_ons => [
        {:add_on_code => "trial", :quantity => 2}, {:add_on_code => "trial2"}
      ]
      subscription.add_ons.to_a.must_equal(
        [{"add_on_code"=>"trial", "quantity"=>2}, {"add_on_code"=>"trial2"}]
      )
    end

    it "must assign track multiple addons" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons.to_a.must_equal(
        [{"add_on_code"=>"trial", "quantity"=>2}]
      )
    end

    it "must assign via hash array" do
      subscription = Subscription.new :add_ons => [
        {:add_on_code => "trial", :quantity => 2}, {:add_on_code => "trial2"}
      ]
      subscription.add_ons.to_a.must_equal(
        [{"add_on_code"=>"trial", "quantity"=>2}, {"add_on_code"=>"trial2"}]
      )
    end

    it "must assign track multiple addons" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons.to_a.must_equal(
        [{"add_on_code"=>"trial", "quantity"=>2}]
      )
    end

    it "must serialize" do
      subscription = Subscription.new
      subscription.add_ons << :trial
      subscription.to_xml.must_equal <<XML.chomp
<subscription>\
<currency>USD</currency>\
<subscription_add_ons>\
<subscription_add_on><add_on_code>trial</add_on_code></subscription_add_on>\
</subscription_add_ons>\
</subscription>
XML
    end

    it "must deserialize" do
      xml = <<XML.chomp
<subscription>\
<currency>USD</currency>\
<subscription_add_ons type="array">\
<subscription_add_on><add_on_code>trial</add_on_code><quantity type="integer">2</quantity></subscription_add_on>
<subscription_add_on><add_on_code>trial2</add_on_code></subscription_add_on>\
</subscription_add_ons>\
</subscription>
XML
      subscription = Subscription.from_xml xml
      subscription.add_ons.to_a.must_equal(
        [{"add_on_code"=>"trial", "quantity"=>2}, {"add_on_code"=>"trial2"}]
      )
    end
  end

  describe "active and inactive" do
    let(:active) {
      stub_api_request :get, 'subscriptions/active', 'subscriptions/show-200'
      Subscription.find 'active'
    }

    let(:inactive) {
      stub_api_request(
        :get, 'subscriptions/inactive', 'subscriptions/show-200-inactive'
      )
      Subscription.find 'inactive'
    }

    describe "#cancel" do
      it "must cancel an active subscription" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/cancel',
          'subscriptions/show-200'
        )
        active.cancel.must_equal true
      end

      it "won't cancel an inactive subscription" do
        inactive.cancel.must_equal false
      end
    end

    describe "#terminate" do
      it "must fully refund a subscription" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/terminate?refund=full',
          'subscriptions/show-200'
        )
        active.terminate(:full).must_equal true
      end

      it "won't fully refund an inactive subscription" do
        inactive.terminate(:full).must_equal false
      end

      it "must partially refund a subscription" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/terminate?refund=partial',
          'subscriptions/show-200'
        )
        active.terminate(:partial).must_equal true
      end

      it "won't partially refund an inactive subscription" do
        inactive.terminate(:partial).must_equal false
      end

      it "must terminate a subscription with no refund" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/terminate?refund=none',
          'subscriptions/show-200'
        )
        active.terminate.must_equal true
      end
    end

    describe "#reactivate" do
      it "must reactivate an inactive subscription" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/reactivate',
          'subscriptions/show-200'
        )
        inactive.reactivate.must_equal true
      end

      it "won't reactivate an active subscription" do
        active.reactivate.must_equal false
      end
    end

    describe "plan assignment" do
      it "must use the assigned plan code" do
        active.plan_code = 'new_plan'
        active.plan_code.must_equal 'new_plan'
      end
    end
  end
end

require 'spec_helper'

describe Subscription do
  describe "attributes" do
    subject { Subscription }

    it "has all expected attributes" do
      expected_attributes = %w{ uuid
                                state
                                unit_amount_in_cents
                                cost_in_cents
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
                                net_terms
                                collection_method
                                po_number
                                tax_in_cents
                                tax_type
                                tax_rate
                                total_billing_cycles
                                remaining_billing_cycles
                                bulk
                                terms_and_conditions
                                customer_notes
                              }

        subject.attribute_names.sort.must_equal expected_attributes.sort
      end
  end

  describe "check serialization" do
    let(:attributes) do
      {
        plan_code: 'gold',
        currency: 'EUR',
        terms_and_conditions: 'Some Terms and Conditions',
        customer_notes: 'Some Customer Notes',
        account: {
          account_code: '1',
          email: 'verena@example.com',
          first_name: 'Verena',
          last_name: 'Example',
          billing_info: {
            number: '4111-1111-1111-1111',
            month: 1,
            year: 2014,
          }
        }
      }
    end

    it "automatic collection" do
      subscription = Subscription.new attributes
      subscription.to_xml.must_equal get_raw_xml("subscriptions/serialize-automatic.xml")
    end
    it "automatic collection with a billing_info token" do
      attributes[:account][:billing_info] = { token_id: 'abc123' }
      subscription = Subscription.new attributes
      subscription.to_xml.must_equal get_raw_xml("subscriptions/serialize-token.xml")
    end
    it "manual collection" do
      subscription = Subscription.new(
        :plan_code => 'gold',
        :currency  => 'EUR',
        :net_terms  => '10',
        :collection_method  => 'manual',
        :po_number  => '1000',
        :account   => {
          :account_code => '1',
        }
      )
      subscription.to_xml.must_equal get_raw_xml("subscriptions/serialize.xml")
    end
    it "check deserialize for manual invoicing" do
      subscription = Subscription.from_xml get_raw_xml("subscriptions/show-200-manual.xml")
      subscription.must_be_instance_of Subscription
      subscription.net_terms.must_equal(10)
      subscription.collection_method.must_equal('manual')
      subscription.po_number.must_equal('1000')
    end

    it 'can deserialize tax information' do
      stub_api_request :get, 'subscriptions/abc1234', 'subscriptions/show-200-taxed'
      subscription = Subscription.find 'abc1234'
      subscription.tax_type.must_equal('usst')
      subscription.tax_in_cents.must_equal(0)
    end

    it "properly serializes bulk attribute" do
      attributes[:bulk] = true
      subscription = Subscription.new attributes
      subscription.to_xml.must_equal get_raw_xml("subscriptions/serialize-with-bulk.xml")
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
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code"=>"trial", "quantity"=>2),
        SubscriptionAddOn.new("add_on_code"=>"trial2")
      ])
    end

    it "must assign track multiple addons" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new({"add_on_code"=>"trial", "quantity"=>2})
      ])
    end

    it "must assign via hash array" do
      subscription = Subscription.new :add_ons => [
        {:add_on_code => "trial", :quantity => 2}, {:add_on_code => "trial2"}
      ]
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code"=>"trial", "quantity"=>2),
        SubscriptionAddOn.new("add_on_code"=>"trial2")
      ])
    end

    it "must assign track multiple addons" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code"=>"trial", "quantity"=>2)
      ])
    end

    it "must serialize" do
      subscription = Subscription.new
      subscription.add_ons << :trial
      subscription.to_xml.must_equal get_raw_xml("subscriptions/serialize-add-ons.xml")
    end

    it "must deserialize" do
      xml = get_raw_xml("subscriptions/deserialize-add-ons.xml")
      subscription = Subscription.from_xml xml
      subscription.pending_subscription.must_be_instance_of Subscription
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code"=>"trial", "quantity"=>2),
        SubscriptionAddOn.new("add_on_code"=>"trial2")
      ])
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

    describe "#invoice" do
      it "has an invoice if present" do
        stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'
        stub_api_request :get, 'invoices/created-invoice', 'invoices/create-201'

        subscription = Subscription.find 'abcdef1234567890'
        subscription.invoice.must_be_instance_of Invoice
      end

      it "invoice is nil if not present" do
        stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200-noinvoice'

        subscription = Subscription.find 'abcdef1234567890'
        subscription.invoice.must_equal nil
      end
    end
  end

  describe 'previewing' do
    it 'previews new subscriptions' do
      stub_api_request :post, 'subscriptions/preview', 'subscriptions/preview-200-new'

      subscription = Subscription.preview(
        plan_code: 'plan_code',
        currency: 'USD',
        account: {
          account_code: 'account_code',
        }
      )

      subscription.plan.plan_code.must_equal 'plan_code'
    end

    it 'previews subscription changes' do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200-noinvoice'
      stub_api_request :post, 'subscriptions/abcdef1234567890/preview', 'subscriptions/preview-200-change'

      subscription = Subscription.find 'abcdef1234567890'
      subscription.quantity = 5
      subscription.preview

      subscription.cost_in_cents.must_equal subscription.unit_amount_in_cents * 5
      subscription.invoice.must_be_instance_of Invoice
    end
  end
end

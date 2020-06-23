require 'spec_helper'

describe Subscription do
  describe "check serialization" do
    let(:attributes) do
      {
        plan_code: 'gold',
        currency: 'EUR',
        terms_and_conditions: 'Some Terms and Conditions',
        customer_notes: 'Some Customer Notes',
        imported_trial: true,
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
        },
        shipping_address_id: 1234,
        shipping_method_code: 'ups_ground',
        shipping_amount_in_cents: 899
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

    it "must accumulate quantity if new addon has quantity" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons << SubscriptionAddOn.new(add_on_code: :trial, quantity: 3)
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new(add_on_code: :trial, quantity: 5)
      ])
    end

    it "must assume new addon has a quantity of 1 if not specified" do
      subscription = Subscription.new :add_ons => [:trial, :trial]
      subscription.add_ons << SubscriptionAddOn.new(add_on_code: :trial)
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new(add_on_code: :trial, quantity: 3)
      ])
    end

    it "must allow add-on from item" do
      item = Item.new(
        item_code: 'mockitem',
        name: 'Mock Item'
      )
      subscription = Subscription.new add_ons: [
        add_on_code: item.item_code,
        add_on_source: "item", 
        unit_amount_in_cents: 199, 
        quantity: 2
      ]

      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code": item.item_code, "add_on_source": "item", "unit_amount_in_cents": 199, "quantity": 2)
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
      subscription.currency.must_equal "GBP"
      subscription.pending_subscription.must_be_instance_of Subscription
      subscription.pending_subscription.currency.must_equal "GBP"
      subscription.add_ons.to_a.must_equal([
        SubscriptionAddOn.new("add_on_code"=>"trial", "quantity"=>2),
        SubscriptionAddOn.new("add_on_code"=>"trial2")
      ])
    end
  end

  describe "custom fields" do
    let(:subscription) {
      stub_api_request :get, 'subscriptions/active', 'subscriptions/show-200'
      Subscription.find 'active'
    }

    it 'should have a custom field' do
      subscription.custom_fields.must_equal [CustomField.new(name: 'sub_field1', value: 'sub-value-1')]
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

      it "will send the timeframe parameter if given" do
        stub_api_request(
          :put,
          'subscriptions/abcdef1234567890/cancel?timeframe=term_end',
          'subscriptions/show-200'
        )

        active.cancel('term_end').must_equal true
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

    it 'should be able to derive and parse address' do
      stub_api_request :post, 'subscriptions/preview', 'subscriptions/preview-200-new'

      subscription = Subscription.preview(
        plan_code: 'plan_code',
        currency: 'USD',
        account: {
          account_code: 'account_code',
        }
      )

      subscription.address.must_be_instance_of Address
      subscription.address.country.must_equal 'US'
    end

    it 'previews subscription changes' do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200-noinvoice'
      stub_api_request :post, 'subscriptions/abcdef1234567890/preview', 'subscriptions/preview-200-change'

      subscription = Subscription.find 'abcdef1234567890'
      subscription.quantity = 5
      subscription.preview

      subscription.cost_in_cents.must_equal subscription.unit_amount_in_cents * 5
      subscription.invoice_collection.must_be_instance_of InvoiceCollection
      subscription.invoice_collection.charge_invoice.must_be_instance_of Invoice
    end
  end

  describe 'pausing and resuming' do
    before do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'
      stub_api_request :put, 'https://api.recurly.com/v2/subscriptions/abcdef1234567890/pause', 'subscriptions/pause-200'
      stub_api_request :put, 'https://api.recurly.com/v2/subscriptions/abcdef1234567890/resume', 'subscriptions/resume-200'
    end

    it "should be able to pause and resume a subscription" do
      sub = Recurly::Subscription.find('abcdef1234567890')
      sub.paused_at.must_equal nil
      sub.pause(1).must_equal true
      sub.paused_at.must_be_instance_of DateTime
      sub.remaining_pause_cycles.must_equal 1
      sub.resume.must_equal true
      sub.remaining_pause_cycles.must_equal nil
    end
  end

  describe 'convert trial' do
    before do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200-trial'
      stub_api_request :put, 'https://api.recurly.com/v2/subscriptions/abcdef1234567890/convert_trial', 'subscriptions/convert-trial-200'
    end
    
    it "should convert trial to paid subscription is valid 3ds token is provided" do
      sub = Recurly::Subscription.find('abcdef1234567890')
      sub.convert_trial("token").must_equal true
      sub.trial_ends_at.must_equal sub.current_period_started_at
    end

    it "should convert trial with billing info but without valid 3ds token" do
      sub = Recurly::Subscription.find('abcdef1234567890')
      sub.convert_trial().must_equal true
    end

    it "should convert trial to paid subscription when transaction_type is moto" do
      sub = Recurly::Subscription.find('abcdef1234567890')
      sub.convert_trial_moto().must_equal true
      sub.trial_ends_at.must_equal sub.current_period_started_at
    end
  end

  describe 'notes' do
    it 'previews new subscriptions' do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'
      stub_api_request :put, 'subscriptions/abcdef1234567890/notes', 'subscriptions/notes-200-change'

      subscription = Subscription.find 'abcdef1234567890'

      notes = {
        customer_notes: 'Some New Customer Notes',
        terms_and_conditions: 'Some New Terms and Conditions',
        vat_reverse_charge_notes: 'Some New Vat Reverse Charge Notes',
        gateway_code: 'Some Gateway Code'
      }

      subscription.update_notes(notes)

      subscription.customer_notes.must_equal notes[:customer_notes]
      subscription.terms_and_conditions.must_equal notes[:terms_and_conditions]
      subscription.vat_reverse_charge_notes.must_equal notes[:vat_reverse_charge_notes]
      subscription.gateway_code.must_equal notes[:gateway_code]
    end
  end

  describe 'redemptions' do
    it 'should return Redemption objects' do
      stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'
      stub_api_request :get, 'subscriptions/abcdef1234567890/redemptions', 'subscriptions/redemptions-200'

      subscription = Subscription.find 'abcdef1234567890'

      redemptions = subscription.redemptions

      redemptions.length.must_equal 2
      redemptions.all? { |r| r.is_a? Redemption }.must_equal true
    end
  end

  describe '#update_attributes' do
    describe 'when the plan code does change' do
      it 'sends all updated atributes to the server' do
        stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'

        subscription = Subscription.find 'abcdef1234567890'

        stub_request(:put, "https://api.recurly.com/v2/subscriptions/abcdef1234567890").
          with(:body => "<subscription><plan_code>abc</plan_code><quantity>1</quantity><unit_amount_in_cents>1500</unit_amount_in_cents></subscription>",
               :headers => Recurly::API.headers).
          to_return(:status => 200, :body => "", :headers => {})

        subscription.update_attributes({ plan_code: 'abc', quantity: 1, unit_amount_in_cents: 1500 })
      end
    end
  end

  describe '#update_attributes' do
    describe 'when the plan code does not change' do
      it 'sends only changed attributes to the server' do
        stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'

        subscription = Subscription.find 'abcdef1234567890'

        stub_request(:put, "https://api.recurly.com/v2/subscriptions/abcdef1234567890").
          with(:body => "<subscription><plan_code>plan_code</plan_code><unit_amount_in_cents>1500</unit_amount_in_cents></subscription>",
               :headers => Recurly::API.headers).
          to_return(:status => 200, :body => "", :headers => {})

        subscription.update_attributes({ plan_code: 'plan_code', quantity: 1, unit_amount_in_cents: 1500 })
      end
    end
  end

  describe "#shipping_address" do
    it "should be able to find shipping address" do
      stub_api_request(
        :get,
        'subscriptions/abcdef1234567890',
        'subscriptions/show-200'
      )
      stub_api_request(
        :get,
        'subscriptions/abcdef1234567890/shipping_address',
        'shipping_addresses/show-200'
      )
      subscription = Recurly::Subscription.find("abcdef1234567890")
      shad = subscription.shipping_address
      shad.must_be_instance_of Recurly::ShippingAddress
    end
  end
end

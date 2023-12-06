require 'spec_helper'

describe ExternalPaymentPhase do
  let(:external_payment_phase) {
    ExternalPaymentPhase.new(
      id: 'sd28t3zdm59p',
      external_subscription: ExternalSubscription.new(id: '123abc'),
      started_at: '2023-01-23T19:02:40Z',
      ends_at: '2023-02-23T19:02:40Z',
      starting_billing_period_index: 1,
      ending_billing_period_index: 4,
      period_count: 1,
      period_length: '2 MONTHS',
      amount: 0.00,
      currency: 'USD',
      created_at: '2023-01-23T19:02:40Z',
      updated_at: '2023-02-23T19:02:40Z'
    )
  }
  let(:external_subscription) {
    stub_api_request :get, 'external_subscriptions/sdam2lfeop3e', 'external_subscriptions/show-200'
    ExternalSubscription.find('sdam2lfeop3e')
  }

  describe "#associations" do
    it "has correct associations" do
      expect(external_payment_phase.external_subscription).must_be_instance_of ExternalSubscription
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(external_payment_phase.id).must_equal('sd28t3zdm59p')
      expect(external_payment_phase.starting_billing_period_index).must_equal(1)
      expect(external_payment_phase.created_at).must_equal('2023-01-23T19:02:40Z')
      expect(external_payment_phase.updated_at).must_equal('2023-02-23T19:02:40Z')
    end
  end

  describe ".get_external_payment_phases" do
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/external_subscriptions/sdam2lfeop3e/external_payment_phases",
        "external_subscriptions/external_payment_phases/index-200"
      )
    end

    it "returns external_payment_phases" do
      external_payment_phase = external_subscription.get_external_payment_phases[0]

      external_payment_phase.must_be_instance_of(ExternalPaymentPhase)
      external_payment_phase.id.must_equal('sk0bmpw0wbby')
      external_payment_phase.created_at.must_equal(DateTime.new(2023, 3, 14, 19, 55, 7))
      external_payment_phase.updated_at.must_equal(DateTime.new(2023, 4, 14, 19, 55, 7))
    end
  end

  describe ".get_external_payment_phase" do
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/external_subscriptions/sdam2lfeop3e/external_payment_phases/sk0bmpw0wbby",
        "external_subscriptions/external_payment_phases/show-200"
      )
    end

    it "returns an external payment phase" do
      external_payment_phase = external_subscription.get_external_payment_phase('sk0bmpw0wbby')

      external_payment_phase.must_be_instance_of(ExternalPaymentPhase)
      external_payment_phase.id.must_equal('sk0bmpw0wbby')
      external_payment_phase.created_at.must_equal(DateTime.new(2023, 3, 14, 19, 55, 7))
      external_payment_phase.updated_at.must_equal(DateTime.new(2023, 4, 14, 19, 55, 7))
    end
  end
end

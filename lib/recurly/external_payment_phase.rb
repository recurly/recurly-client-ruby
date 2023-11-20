module Recurly
  class ExternalPaymentPhase < Resource

    # @return [ExternalSubscription]
    belongs_to :external_subscription

    define_attribute_methods %w(
      id
      started_at
      ends_at
      starting_billing_period_index
      ending_billing_period_index
      offer_type
      offer_name
      period_count
      period_length
      amount
      currency
      created_at
      updated_at
    )

    # We do not expose POST or PUT via the v2 API
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

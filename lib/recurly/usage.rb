module Recurly
  class Usage < Resource
    # @return [MeasuredUnit]
    belongs_to :measured_unit

    define_attribute_methods %w(
      id
      usage_type
      unit_amount_in_cents
      usage_percentage
      amount
      merchant_tag
      usage_timestamp
      recording_timestamp
      billed_at
      created_at
      updated_at
    )

    # Usages are only writeable and readable through {SubscriptionAddOns} instances.
    embedded!
    private_class_method :find
  end
end

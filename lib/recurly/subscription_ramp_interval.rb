module Recurly
  class SubscriptionRampInterval < Resource
    belongs_to :subscription

    define_attribute_methods %w(
      starting_billing_cycle
      unit_amount_in_cents
      starting_on
      ending_on
    )
  end
end

module Recurly
  class PlanRampInterval < Resource
    belongs_to :plan

    define_attribute_methods %w(
      starting_billing_cycle
      unit_amount_in_cents
    )
  end
end

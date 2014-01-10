module Recurly
  class Plan < Resource
    # @return [Pager<AddOn>, []]
    has_many :add_ons

    define_attribute_methods %w(
      plan_code
      name
      description
      success_url
      cancel_url
      display_donation_amounts
      display_quantity
      display_phone_number
      bypass_hosted_confirmation
      unit_name
      payment_page_tos_link
      payment_page_css
      setup_fee_in_cents
      unit_amount_in_cents
      plan_interval_length
      plan_interval_unit
      trial_interval_length
      trial_interval_unit
      total_billing_cycles
      accounting_code
      tax_exempt
      created_at
    )
    alias to_param plan_code
  end
end

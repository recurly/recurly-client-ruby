require_relative './rev_rec'

module Recurly
  # Recurly Documentation: https://dev.recurly.com/docs/list-plans
  class Plan < Resource

    # @return [Pager<AddOn>, []]
    has_many :add_ons

    # @return <ExternalProduct>
    has_one :external_product

    # @return [[PlanRampInterval], nil]
    has_many :ramp_intervals, class_name: :PlanRampInterval

    # @return [[CustomField], []]
    has_many :custom_fields, class_name: :CustomField, readonly: false

    # Define attribute methods
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
      pricing_model
      ramp_intervals
      trial_interval_length
      trial_interval_unit
      total_billing_cycles
      accounting_code
      setup_fee_accounting_code
      revenue_schedule_type
      setup_fee_revenue_schedule_type
      tax_exempt
      tax_code
      trial_requires_billing_info
      auto_renew
      allow_any_item_on_subscriptions
      avalara_transaction_type
      avalara_service_type
      dunning_campaign_id
      custom_fields
      created_at
      updated_at
    ) + RevRec::PLAN_ATTRIBUTES
    alias to_param plan_code
  end
end

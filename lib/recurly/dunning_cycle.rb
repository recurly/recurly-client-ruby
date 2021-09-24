module Recurly
  class DunningCycle < Resource
    define_attribute_methods %w(
      type
      applies_to_manual_trial
      first_communication_interval
      send_immediately_on_hard_decline
      intervals
      expire_subscription
      fail_invoice
      total_dunning_days
      total_recycling_days
      version
      created_at
      updated_at
    )
  end
end

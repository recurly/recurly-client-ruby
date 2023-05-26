module Recurly
  # Additional attributes to pass to the gateway
  class GatewayAttribute < Resource
    belongs_to :billing_info, class_name: :BillingInfo

    define_attribute_methods %w(
      account_reference,
    )
  end
end

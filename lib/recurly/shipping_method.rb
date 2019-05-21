module Recurly
  class ShippingMethod < Resource
    define_attribute_methods %w(
      code
      name
      accounting_code
      tax_code
      created_at
      updated_at
    )
    alias to_param code
  end
end

module Recurly
  class ShippingAddress < Resource
    define_attribute_methods %w(
      id
      address1
      address2
      first_name
      last_name
      city
      state
      zip
      country
      phone
      nickname
      company
      email
      geo_code
    )
    alias to_param address1
  end
end

module Recurly
  # Recurly Documentation: https://dev.recurly.com/docs/list-accounts-shipping-address
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
      company_name
      email
      geo_code
      vat_number
      street1
      street2
    )
    alias to_param address1
  end
end

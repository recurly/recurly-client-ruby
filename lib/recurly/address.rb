module Recurly
  class Address < Resource

    define_attribute_methods %w(
      address1
      address2
      city
      state
      zip
      country
      phone
      geo_code
    )
  end
end

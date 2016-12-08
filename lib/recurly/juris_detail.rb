module Recurly
  class JurisDetail < Resource
    define_attribute_methods %w(
      description
      jurisdiction
      rate
      tax_in_cents
      sub_type
      jurisdiction_name
    )

    embedded! true
  end
end

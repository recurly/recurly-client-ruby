require 'bigdecimal'

module Recurly
  class TaxDetail < Resource
    define_attribute_methods %w(
      name
      type
      tax_rate
      tax_in_cents
    )

    embedded! true
  end
end

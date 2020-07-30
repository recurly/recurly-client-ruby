require 'bigdecimal'

module Recurly
  class TaxDetail < Resource
    define_attribute_methods %w(
      name
      type
      tax_rate
      tax_in_cents
      level
      billable
    )

    embedded! true
  end
end

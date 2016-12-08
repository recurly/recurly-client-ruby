module Recurly
  class TaxType < Resource
    define_attribute_methods %w(
      description
      tax_in_cents
      type
      juris_details
    )

    embedded! true
  end
end

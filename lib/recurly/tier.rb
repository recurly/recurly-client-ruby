module Recurly
  class Tier < Resource

    belongs_to :add_on

    define_attribute_methods %w(
      ending_quantity
      unit_amount_in_cents
    )

    embedded! true
  end
end

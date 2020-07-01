module Recurly
  class Tier < Resource

    belongs_to :add_on

    define_attribute_methods %w(
      ending_quantity
      unit_amount_in_cents
    )

    def xml_keys
      attributes.keys
    end

    # Tiers are only writeable and readable through {AddOn} instances.
    embedded! true
  end
end

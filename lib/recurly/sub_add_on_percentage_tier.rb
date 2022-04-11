module Recurly
  class SubAddOnPercentageTier < Resource

    belongs_to :subscription_add_on

    define_attribute_methods %w(
      ending_amount_in_cents
      usage_percentage
    )

    def xml_keys
      attributes.keys
    end

    embedded! true
  end
end

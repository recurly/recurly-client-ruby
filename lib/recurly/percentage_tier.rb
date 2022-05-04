module Recurly
  class PercentageTier < Resource

    belongs_to :currency_percentage_tier

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

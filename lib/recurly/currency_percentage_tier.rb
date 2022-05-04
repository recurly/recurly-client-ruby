module Recurly
  class CurrencyPercentageTier < Resource

    belongs_to :add_on
    has_many :tiers, class_name: :PercentageTier, readonly: false

    define_attribute_methods %w(
      currency
    )

    def xml_keys
      attributes.keys
    end

    embedded! true
  end
end

module Recurly
  module Resources
    class Settings < Resource

      # @!attribute [r] accepted_currencies
      #   @return [Array[String]]
      define_attribute :accepted_currencies, Array, {:item_type => String, :read_only => true}

      # @!attribute [r] billing_address_requirement
      #   @return [String] - full:      Full Address (Street, City, State, Postal Code and Country) - streetzip: Street and Postal Code only - zip:       Postal Code only - none:      No Address
      define_attribute :billing_address_requirement, String, {:read_only => true, :enum => ["full", "streetzip", "zip", "none"]}

      # @!attribute [r] default_currency
      #   @return [String] The default 3-letter ISO 4217 currency code.
      define_attribute :default_currency, String, {:read_only => true}
    end
  end
end

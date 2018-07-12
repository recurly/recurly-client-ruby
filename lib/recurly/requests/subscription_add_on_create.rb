module Recurly
  module Requests
    class SubscriptionAddOnCreate < Request

      # @!attribute code
      #   @return [String] Add-on code
      define_attribute :code, String

      # @!attribute id
      #   @return [String] Id of an existing subscription add on.
      define_attribute :id, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity.
      define_attribute :quantity, Integer

      # @!attribute unit_amount
      #   @return [Float] Override the default unit amount of the add-on by setting this value.
      define_attribute :unit_amount, Float

    end
  end
end

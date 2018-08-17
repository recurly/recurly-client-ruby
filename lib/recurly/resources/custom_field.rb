module Recurly
  module Resources
    class CustomField < Resource

      # @!attribute name
      #   @return [String] Fields must be created in the UI before values can be assigned to them.
      define_attribute :name, String

      # @!attribute value
      #   @return [String] Any values that resemble a credit card number or security code (CVV/CVC) will be rejected.
      define_attribute :value, String
    end
  end
end

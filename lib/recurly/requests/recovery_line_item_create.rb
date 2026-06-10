# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryLineItemCreate < Request

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute description
      #   @return [String] Description that appears on the invoice.
      define_attribute :description, String

      # @!attribute harmonized_system_code
      #   @return [String] The Harmonized System (HS) code is an internationally standardized system of names and numbers to classify traded products. The HS code, sometimes called Commodity Code, is used by customs authorities around the world to identify products when assessing duties and taxes. The HS code may also be referred to as the tariff code or customs code. Values should contain only digits and decimals.
      define_attribute :harmonized_system_code, String

      # @!attribute product_code
      #   @return [String] Optional field to track a product code or SKU for the line item. This can be used to later reporting on product purchases.
      define_attribute :product_code, String

      # @!attribute quantity
      #   @return [Integer] This number will be multiplied by the unit amount to compute the subtotal before any discounts or taxes.
      define_attribute :quantity, Integer

      # @!attribute tax
      #   @return [Float] The tax amount for the line item.
      define_attribute :tax, Float

      # @!attribute unit_amount
      #   @return [Float] A positive or negative amount will result in a positive `unit_amount`.
      define_attribute :unit_amount, Float
    end
  end
end

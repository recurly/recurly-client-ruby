# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ShippingMethodMini < Resource

      # @!attribute code
      #   @return [String] The internal name used identify the shipping method.
      define_attribute :code, String

      # @!attribute id
      #   @return [String] Shipping Method ID
      define_attribute :id, String

      # @!attribute name
      #   @return [String] The name of the shipping method displayed to customers.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
    end
  end
end

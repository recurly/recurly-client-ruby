# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ItemMini < Resource

      # @!attribute code
      #   @return [String] Unique code to identify the item.
      define_attribute :code, String

      # @!attribute description
      #   @return [String] Optional, description.
      define_attribute :description, String

      # @!attribute id
      #   @return [String] Item ID
      define_attribute :id, String

      # @!attribute name
      #   @return [String] This name describes your item and will appear on the invoice when it's purchased on a one time basis.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute state
      #   @return [String] The current state of the item.
      define_attribute :state, String
    end
  end
end

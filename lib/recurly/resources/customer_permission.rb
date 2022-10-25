# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CustomerPermission < Resource

      # @!attribute code
      #   @return [String] Customer permission code.
      define_attribute :code, String

      # @!attribute description
      #   @return [String] Description of customer permission.
      define_attribute :description, String

      # @!attribute id
      #   @return [String] Customer permission ID.
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Customer permission name.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] It will always be "customer_permission".
      define_attribute :object, String
    end
  end
end

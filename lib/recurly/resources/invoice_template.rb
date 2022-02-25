# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class InvoiceTemplate < Resource

      # @!attribute code
      #   @return [String] Invoice template code.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] When the invoice template was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute description
      #   @return [String] Invoice template description.
      define_attribute :description, String

      # @!attribute id
      #   @return [String]
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Invoice template name.
      define_attribute :name, String

      # @!attribute updated_at
      #   @return [DateTime] When the invoice template was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

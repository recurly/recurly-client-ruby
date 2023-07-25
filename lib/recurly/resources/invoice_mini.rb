# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class InvoiceMini < Resource

      # @!attribute business_entity_id
      #   @return [String] Unique ID to identify the business entity assigned to the invoice. Available when the `Multiple Business Entities` feature is enabled.
      define_attribute :business_entity_id, String

      # @!attribute id
      #   @return [String] Invoice ID
      define_attribute :id, String

      # @!attribute number
      #   @return [String] Invoice number
      define_attribute :number, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute state
      #   @return [String] Invoice state
      define_attribute :state, String

      # @!attribute type
      #   @return [String] Invoice type
      define_attribute :type, String
    end
  end
end

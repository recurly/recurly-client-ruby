# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalResourceMini < Resource

      # @!attribute external_object_reference
      #   @return [String] Identifier or URL reference where the resource is canonically available in the external platform.
      define_attribute :external_object_reference, String

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external resource ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
    end
  end
end

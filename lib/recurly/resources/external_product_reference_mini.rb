# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalProductReferenceMini < Resource

      # @!attribute created_at
      #   @return [DateTime] When the external product was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute external_connection_type
      #   @return [String] Source connection platform.
      define_attribute :external_connection_type, String

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external product ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] object
      define_attribute :object, String

      # @!attribute reference_code
      #   @return [String] A code which associates the external product to a corresponding object or resource in an external platform like the Apple App Store or Google Play Store.
      define_attribute :reference_code, String

      # @!attribute updated_at
      #   @return [DateTime] When the external product was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalProductReferenceBase < Request

      # @!attribute external_connection_type
      #   @return [String]
      define_attribute :external_connection_type, String

      # @!attribute reference_code
      #   @return [String] A code which associates the external product to a corresponding object or resource in an external platform like the Apple App Store or Google Play Store.
      define_attribute :reference_code, String
    end
  end
end

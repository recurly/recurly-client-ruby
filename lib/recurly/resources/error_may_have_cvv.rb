# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ErrorMayHaveCVV < Resource

      # @!attribute message
      #   @return [String] The security code you entered does not match. Please update the CVV and try again.
      define_attribute :message, String

      # @!attribute type
      #   @return [String] Type
      define_attribute :type, String
    end
  end
end

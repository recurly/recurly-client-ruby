# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TransactionNextAction < Resource

      # @!attribute type
      #   @return [String] The type of next action required.
      define_attribute :type, String

      # @!attribute value
      #   @return [String] The value associated with the next action type.
      define_attribute :value, String
    end
  end
end

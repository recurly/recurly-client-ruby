# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class CustomField < Request
      
      # @!attribute name
      #   @return [String] Fields must be created in the UI before values can be assigned to them.
      define_attribute :name, String
      
      # @!attribute value
      #   @return [String] Any values that resemble a credit card number or security code (CVV/CVC) will be rejected.
      define_attribute :value, String
      
    end
  end
end

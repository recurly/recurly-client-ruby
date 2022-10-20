# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TransactionPaymentGateway < Resource
      
      # @!attribute id
      #   @return [String] 
      define_attribute :id, String
      
      # @!attribute name
      #   @return [String] 
      define_attribute :name, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
      # @!attribute type
      #   @return [String] 
      define_attribute :type, String
      
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class LineItemRefund < Request
      
      # @!attribute id
      #   @return [String] Line item ID
      define_attribute :id, String
      
      # @!attribute prorate
      #   @return [Boolean] Set to `true` if the line item should be prorated; set to `false` if not. This can only be used on line items that have a start and end date. 
      define_attribute :prorate, :Boolean
      
      # @!attribute quantity
      #   @return [Integer] Line item quantity to be refunded.
      define_attribute :quantity, Integer
      
    end
  end
end

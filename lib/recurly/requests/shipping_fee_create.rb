# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ShippingFeeCreate < Request
      
      # @!attribute amount
      #   @return [Float] This is priced in the purchase's currency.
      define_attribute :amount, Float
      
      # @!attribute method_code
      #   @return [String] The code of the shipping method used to deliver the purchase. If `method_id` and `method_code` are both present, `method_id` will be used.
      define_attribute :method_code, String
      
      # @!attribute method_id
      #   @return [String] The id of the shipping method used to deliver the purchase. If `method_id` and `method_code` are both present, `method_id` will be used.
      define_attribute :method_id, String
      
    end
  end
end

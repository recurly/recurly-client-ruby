# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionShipping < Resource
      
      # @!attribute address
      #   @return [ShippingAddress] 
      define_attribute :address, :ShippingAddress
      
      # @!attribute amount
      #   @return [Float] Subscription's shipping cost
      define_attribute :amount, Float
      
      # @!attribute method
      #   @return [ShippingMethodMini] 
      define_attribute :method, :ShippingMethodMini
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
    end
  end
end

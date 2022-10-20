# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionShippingUpdate < Request
      
      # @!attribute address
      #   @return [ShippingAddressCreate] 
      define_attribute :address, :ShippingAddressCreate
      
      # @!attribute address_id
      #   @return [String] Assign a shipping address from the account's existing shipping addresses.
      define_attribute :address_id, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
    end
  end
end

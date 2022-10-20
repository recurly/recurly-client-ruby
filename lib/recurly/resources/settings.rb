# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Settings < Resource
      
      # @!attribute accepted_currencies
      #   @return [Array[String]] 
      define_attribute :accepted_currencies, Array, {:item_type=>String}
      
      # @!attribute billing_address_requirement
      #   @return [String] - full:      Full Address (Street, City, State, Postal Code and Country) - streetzip: Street and Postal Code only - zip:       Postal Code only - none:      No Address 
      define_attribute :billing_address_requirement, String
      
      # @!attribute default_currency
      #   @return [String] The default 3-letter ISO 4217 currency code.
      define_attribute :default_currency, String
      
    end
  end
end

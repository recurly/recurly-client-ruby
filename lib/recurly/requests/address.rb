# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class Address < Request

      # @!attribute city
      #   @return [String] City
      define_attribute :city, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO 3166-1 alpha-2 code.
      define_attribute :country, String

      # @!attribute phone
      #   @return [String] Phone number
      define_attribute :phone, String

      # @!attribute postal_code
      #   @return [String] Zip or postal code.
      define_attribute :postal_code, String

      # @!attribute region
      #   @return [String] State or province.
      define_attribute :region, String

      # @!attribute street1
      #   @return [String] Street 1
      define_attribute :street1, String

      # @!attribute street2
      #   @return [String] Street 2
      define_attribute :street2, String
    end
  end
end

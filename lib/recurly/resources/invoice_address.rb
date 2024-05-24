# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class InvoiceAddress < Resource

      # @!attribute city
      #   @return [String] City
      define_attribute :city, String

      # @!attribute company
      #   @return [String] Company
      define_attribute :company, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO 3166-1 alpha-2 code.
      define_attribute :country, String

      # @!attribute first_name
      #   @return [String] First name
      define_attribute :first_name, String

      # @!attribute geo_code
      #   @return [String] Code that represents a geographic entity (location or object). Only returned for Sling Vertex Integration
      define_attribute :geo_code, String

      # @!attribute last_name
      #   @return [String] Last name
      define_attribute :last_name, String

      # @!attribute name_on_account
      #   @return [String] Name on account
      define_attribute :name_on_account, String

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

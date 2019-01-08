# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ShippingAddressUpdate < Request

      # @!attribute city
      #   @return [String]
      define_attribute :city, String

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO code.
      define_attribute :country, String

      # @!attribute email
      #   @return [String]
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute [r] id
      #   @return [String] Shipping Address ID
      define_attribute :id, String, {:read_only => true}

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute nickname
      #   @return [String]
      define_attribute :nickname, String

      # @!attribute phone
      #   @return [String]
      define_attribute :phone, String

      # @!attribute postal_code
      #   @return [String] Zip or postal code.
      define_attribute :postal_code, String

      # @!attribute region
      #   @return [String] State or province.
      define_attribute :region, String

      # @!attribute street1
      #   @return [String]
      define_attribute :street1, String

      # @!attribute street2
      #   @return [String]
      define_attribute :street2, String

      # @!attribute vat_number
      #   @return [String]
      define_attribute :vat_number, String
    end
  end
end

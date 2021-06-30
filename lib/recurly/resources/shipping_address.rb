# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ShippingAddress < Resource

      # @!attribute account_id
      #   @return [String] Account ID
      define_attribute :account_id, String

      # @!attribute city
      #   @return [String]
      define_attribute :city, String

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO 3166-1 alpha-2 code.
      define_attribute :country, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute email
      #   @return [String]
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute id
      #   @return [String] Shipping Address ID
      define_attribute :id, String

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute nickname
      #   @return [String]
      define_attribute :nickname, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

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

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime

      # @!attribute vat_number
      #   @return [String]
      define_attribute :vat_number, String
    end
  end
end

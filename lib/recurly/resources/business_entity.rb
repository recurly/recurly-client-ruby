# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class BusinessEntity < Resource

      # @!attribute code
      #   @return [String] The entity code of the business entity.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute default_registration_number
      #   @return [String] Registration number for the customer used on the invoice.
      define_attribute :default_registration_number, String

      # @!attribute default_vat_number
      #   @return [String] VAT number for the customer used on the invoice.
      define_attribute :default_vat_number, String

      # @!attribute id
      #   @return [String] Business entity ID
      define_attribute :id, String

      # @!attribute invoice_display_address
      #   @return [Address] Address information for the business entity that will appear on the invoice.
      define_attribute :invoice_display_address, :Address

      # @!attribute name
      #   @return [String] This name describes your business entity and will appear on the invoice.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute subscriber_location_countries
      #   @return [Array[String]] List of countries for which the business entity will be used.
      define_attribute :subscriber_location_countries, Array, { :item_type => String }

      # @!attribute tax_address
      #   @return [Address] Address information for the business entity that will be used for calculating taxes.
      define_attribute :tax_address, :Address

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

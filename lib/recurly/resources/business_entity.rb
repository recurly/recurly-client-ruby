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

      # @!attribute default_liability_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :default_liability_gl_account_id, String

      # @!attribute default_registration_number
      #   @return [String] Registration number for the customer used on the invoice.
      define_attribute :default_registration_number, String

      # @!attribute default_revenue_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :default_revenue_gl_account_id, String

      # @!attribute default_vat_number
      #   @return [String] VAT number for the customer used on the invoice.
      define_attribute :default_vat_number, String

      # @!attribute destination_tax_address_source
      #   @return [String] The source of the address that will be used as the destinaion in determining taxes. Available only when the site is on an Elite plan. A value of "destination" refers to the "Customer tax address". A value of "origin" refers to the "Business entity tax address".
      define_attribute :destination_tax_address_source, String

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

      # @!attribute origin_tax_address_source
      #   @return [String] The source of the address that will be used as the origin in determining taxes. Available only when the site is on an Elite plan. A value of "origin" refers to the "Business entity tax address". A value of "destination" refers to the "Customer tax address".
      define_attribute :origin_tax_address_source, String

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

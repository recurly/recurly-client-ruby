# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ItemCreate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items.
      define_attribute :accounting_code, String

      # @!attribute code
      #   @return [String] Unique code to identify the item.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[Pricing]] Item Pricing
      define_attribute :currencies, Array, { :item_type => :Pricing }

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute description
      #   @return [String] Optional, description.
      define_attribute :description, String

      # @!attribute external_sku
      #   @return [String] Optional, stock keeping unit to link the item to other inventory systems.
      define_attribute :external_sku, String

      # @!attribute name
      #   @return [String] This name describes your item and will appear on the invoice when it's purchased on a one time basis.
      define_attribute :name, String

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute tax_code
      #   @return [String] Used by Avalara, Vertex, and Recurly’s EU VAT tax feature. The tax code values are specific to each tax system. If you are using Recurly’s EU VAT feature you can use `unknown`, `physical`, or `digital`.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on the item, `false` applies tax on the item.
      define_attribute :tax_exempt, :Boolean
    end
  end
end

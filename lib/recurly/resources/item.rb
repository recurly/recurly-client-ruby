# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Item < Resource
      
      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items.
      define_attribute :accounting_code, String
      
      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_service_type, Integer
      
      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the item is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_transaction_type, Integer
      
      # @!attribute code
      #   @return [String] Unique code to identify the item.
      define_attribute :code, String
      
      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime
      
      # @!attribute currencies
      #   @return [Array[Pricing]] Item Pricing
      define_attribute :currencies, Array, {:item_type=>:Pricing}
      
      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, {:item_type=>:CustomField}
      
      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime
      
      # @!attribute description
      #   @return [String] Optional, description.
      define_attribute :description, String
      
      # @!attribute external_sku
      #   @return [String] Optional, stock keeping unit to link the item to other inventory systems.
      define_attribute :external_sku, String
      
      # @!attribute id
      #   @return [String] Item ID
      define_attribute :id, String
      
      # @!attribute name
      #   @return [String] This name describes your item and will appear on the invoice when it's purchased on a one time basis.
      define_attribute :name, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String
      
      # @!attribute state
      #   @return [String] The current state of the item.
      define_attribute :state, String
      
      # @!attribute tax_code
      #   @return [String] Used by Avalara, Vertex, and Recurly’s EU VAT tax feature. The tax code values are specific to each tax system. If you are using Recurly’s EU VAT feature you can use `unknown`, `physical`, or `digital`.
      define_attribute :tax_code, String
      
      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on the item, `false` applies tax on the item.
      define_attribute :tax_exempt, :Boolean
      
      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
      
    end
  end
end

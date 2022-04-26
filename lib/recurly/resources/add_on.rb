# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AddOn < Resource

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for this add-on. If no value is provided, it defaults to add-on's code.
      define_attribute :accounting_code, String

      # @!attribute add_on_type
      #   @return [String] Whether the add-on type is fixed, or usage-based.
      define_attribute :add_on_type, String

      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the add-on is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_service_type, Integer

      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the add-on is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_transaction_type, Integer

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currencies
      #   @return [Array[AddOnPricing]] Add-on pricing
      define_attribute :currencies, Array, { :item_type => :AddOnPricing }

      # @!attribute default_quantity
      #   @return [Integer] Default quantity for the hosted pages.
      define_attribute :default_quantity, Integer

      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime

      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the add-on.
      define_attribute :display_quantity, :Boolean

      # @!attribute external_sku
      #   @return [String] Optional, stock keeping unit to link the item to other inventory systems.
      define_attribute :external_sku, String

      # @!attribute id
      #   @return [String] Add-on ID
      define_attribute :id, String

      # @!attribute item
      #   @return [ItemMini] Just the important parts.
      define_attribute :item, :ItemMini

      # @!attribute measured_unit_id
      #   @return [String] System-generated unique identifier for an measured unit associated with the add-on.
      define_attribute :measured_unit_id, String

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute optional
      #   @return [Boolean] Whether the add-on is optional for the customer to include in their purchase on the hosted payment page. If false, the add-on will be included when a subscription is created through the Recurly UI. However, the add-on will not be included when a subscription is created through the API.
      define_attribute :optional, :Boolean

      # @!attribute percentage_tiers
      #   @return [Array[PercentageTiersByCurrency]] Percentage Tiers
      define_attribute :percentage_tiers, Array, { :item_type => :PercentageTiersByCurrency }

      # @!attribute plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String

      # @!attribute revenue_schedule_type
      #   @return [String] When this add-on is invoiced, the line item will use this revenue schedule. If `item_code`/`item_id` is part of the request then `revenue_schedule_type` must be absent in the request as the value will be set from the item.
      define_attribute :revenue_schedule_type, String

      # @!attribute state
      #   @return [String] Add-ons can be either active or inactive.
      define_attribute :state, String

      # @!attribute tax_code
      #   @return [String] Used by Avalara, Vertex, and Recurly’s EU VAT tax feature. The tax code values are specific to each tax system. If you are using Recurly’s EU VAT feature you can use `unknown`, `physical`, or `digital`.
      define_attribute :tax_code, String

      # @!attribute tier_type
      #   @return [String] The pricing model for the add-on.  For more information, [click here](https://docs.recurly.com/docs/billing-models#section-quantity-based). See our [Guide](https://developers.recurly.com/guides/item-addon-guide.html) for an overview of how to configure quantity-based pricing models.
      define_attribute :tier_type, String

      # @!attribute tiers
      #   @return [Array[Tier]] Tiers
      define_attribute :tiers, Array, { :item_type => :Tier }

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime

      # @!attribute usage_percentage
      #   @return [String] The percentage taken of the monetary amount of usage tracked. This can be up to 4 decimal places. A value between 0.0 and 100.0, represented as a string.
      define_attribute :usage_percentage, String

      # @!attribute usage_timeframe
      #   @return [String] The time at which usage totals are reset for billing purposes.
      define_attribute :usage_timeframe, String

      # @!attribute usage_type
      #   @return [String] Type of usage, returns usage type if `add_on_type` is `usage`.
      define_attribute :usage_type, String
    end
  end
end

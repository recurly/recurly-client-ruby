# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AddOnCreate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for this add-on. If no value is provided, it defaults to add-on's code. If `item_code`/`item_id` is part of the request then `accounting_code` must be absent.
      define_attribute :accounting_code, String

      # @!attribute add_on_type
      #   @return [String] Whether the add-on type is fixed, or usage-based.
      define_attribute :add_on_type, String

      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the add-on is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types. If an `Item` is associated to the `AddOn`, then the `avalara_service_type` must be absent.
      define_attribute :avalara_service_type, Integer

      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the add-on is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types. If an `Item` is associated to the `AddOn`, then the `avalara_transaction_type` must be absent.
      define_attribute :avalara_transaction_type, Integer

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan. If `item_code`/`item_id` is part of the request then `code` must be absent. If `item_code`/`item_id` is not present `code` is required.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[AddOnPricing]] * If `item_code`/`item_id` is part of the request and the item has a default currency then `currencies` is optional. If the item does not have a default currency, then `currencies` is required. If `item_code`/`item_id` is not present `currencies` is required. * If the add-on's `tier_type` is `tiered`, `volume`, or `stairstep`, then `currencies` must be absent. * Must be absent if `add_on_type` is `usage` and `usage_type` is `percentage`.
      define_attribute :currencies, Array, { :item_type => :AddOnPricing }

      # @!attribute default_quantity
      #   @return [Integer] Default quantity for the hosted pages.
      define_attribute :default_quantity, Integer

      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the add-on.
      define_attribute :display_quantity, :Boolean

      # @!attribute item_code
      #   @return [String] Unique code to identify an item. Available when the `Credit Invoices` and `Subscription Billing Terms` features are enabled. If `item_id` and `item_code` are both present, `item_id` will be used.
      define_attribute :item_code, String

      # @!attribute item_id
      #   @return [String] System-generated unique identifier for an item. Available when the `Credit Invoices` and `Subscription Billing Terms` features are enabled. If `item_id` and `item_code` are both present, `item_id` will be used.
      define_attribute :item_id, String

      # @!attribute measured_unit_id
      #   @return [String] System-generated unique identifier for a measured unit to be associated with the add-on. Either `measured_unit_id` or `measured_unit_name` are required when `add_on_type` is `usage`. If `measured_unit_id` and `measured_unit_name` are both present, `measured_unit_id` will be used.
      define_attribute :measured_unit_id, String

      # @!attribute measured_unit_name
      #   @return [String] Name of a measured unit to be associated with the add-on. Either `measured_unit_id` or `measured_unit_name` are required when `add_on_type` is `usage`. If `measured_unit_id` and `measured_unit_name` are both present, `measured_unit_id` will be used.
      define_attribute :measured_unit_name, String

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices. If `item_code`/`item_id` is part of the request then `name` must be absent. If `item_code`/`item_id` is not present `name` is required.
      define_attribute :name, String

      # @!attribute optional
      #   @return [Boolean] Whether the add-on is optional for the customer to include in their purchase on the hosted payment page. If false, the add-on will be included when a subscription is created through the Recurly UI. However, the add-on will not be included when a subscription is created through the API.
      define_attribute :optional, :Boolean

      # @!attribute plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String

      # @!attribute revenue_schedule_type
      #   @return [String] When this add-on is invoiced, the line item will use this revenue schedule. If `item_code`/`item_id` is part of the request then `revenue_schedule_type` must be absent in the request as the value will be set from the item.
      define_attribute :revenue_schedule_type, String

      # @!attribute tax_code
      #   @return [String] Optional field used by Avalara, Vertex, and Recurly's EU VAT tax feature to determine taxation rules. If you have your own AvaTax or Vertex account configured, use their tax codes to assign specific tax rules. If you are using Recurly's EU VAT feature, you can use values of `unknown`, `physical`, or `digital`. If `item_code`/`item_id` is part of the request then `tax_code` must be absent.
      define_attribute :tax_code, String

      # @!attribute tier_type
      #   @return [String] The pricing model for the add-on.  For more information, [click here](https://docs.recurly.com/docs/billing-models#section-quantity-based). See our [Guide](https://developers.recurly.com/guides/item-addon-guide.html) for an overview of how to configure quantity-based pricing models.
      define_attribute :tier_type, String

      # @!attribute tiers
      #   @return [Array[Tier]] If the tier_type is `flat`, then `tiers` must be absent. The `tiers` object must include one to many tiers with `ending_quantity` and `unit_amount` for the desired `currencies`, or alternatively, `usage_percentage` for usage percentage type usage add ons. There must be one tier with an `ending_quantity` of 999999999 which is the default if not provided.
      define_attribute :tiers, Array, { :item_type => :Tier }

      # @!attribute usage_percentage
      #   @return [Float] The percentage taken of the monetary amount of usage tracked. This can be up to 4 decimal places. A value between 0.0 and 100.0. Required if `add_on_type` is usage, `tier_type` is `flat` and `usage_type` is percentage. Must be omitted otherwise.
      define_attribute :usage_percentage, Float

      # @!attribute usage_type
      #   @return [String] Type of usage, required if `add_on_type` is `usage`. See our [Guide](https://developers.recurly.com/guides/usage-based-billing-guide.html) for an overview of how to configure usage add-ons.
      define_attribute :usage_type, String
    end
  end
end

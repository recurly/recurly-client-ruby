# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AddOnUpdate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for this add-on. If no value is provided, it defaults to add-on's code. If an `Item` is associated to the `AddOn` then `accounting code` must be absent.
      define_attribute :accounting_code, String

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan. If an `Item` is associated to the `AddOn` then `code` must be absent.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[AddOnPricing]] If the add-on's `tier_type` is `tiered`, `volume` or `stairstep`, then `currencies` must be absent.
      define_attribute :currencies, Array, { :item_type => :AddOnPricing }

      # @!attribute default_quantity
      #   @return [Integer] Default quantity for the hosted pages.
      define_attribute :default_quantity, Integer

      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the add-on.
      define_attribute :display_quantity, :Boolean

      # @!attribute id
      #   @return [String] Add-on ID
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices. If an `Item` is associated to the `AddOn` then `name` must be absent.
      define_attribute :name, String

      # @!attribute optional
      #   @return [Boolean] Whether the add-on is optional for the customer to include in their purchase on the hosted payment page. If false, the add-on will be included when a subscription is created through the Recurly UI. However, the add-on will not be included when a subscription is created through the API.
      define_attribute :optional, :Boolean

      # @!attribute revenue_schedule_type
      #   @return [String] When this add-on is invoiced, the line item will use this revenue schedule. If an `Item` is associated to the `AddOn` then `revenue_schedule_type` must be absent in the request as the value will be set from the item.
      define_attribute :revenue_schedule_type, String

      # @!attribute tax_code
      #   @return [String] Optional field used by Avalara, Vertex, and Recurly's EU VAT tax feature to determine taxation rules. If you have your own AvaTax or Vertex account configured, use their tax codes to assign specific tax rules. If you are using Recurly's EU VAT feature, you can use values of `unknown`, `physical`, or `digital`. If an `Item` is associated to the `AddOn` then `tax code` must be absent.
      define_attribute :tax_code, String

      # @!attribute tiers
      #   @return [Array[Tier]] If the tier_type is `flat`, then `tiers` must be absent. The `tiers` object must include one to many tiers with `ending_quantity` and `unit_amount` for the desired `currencies`. There must be one tier with an `ending_quantity` of 999999999 which is the default if not provided.
      define_attribute :tiers, Array, { :item_type => :Tier }
    end
  end
end

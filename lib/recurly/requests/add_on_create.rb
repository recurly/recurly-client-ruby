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

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan. If `item_code`/`item_id` is part of the request then `code` must be absent. If `item_code`/`item_id` is not present `code` is required.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[AddOnPricing]] If `item_code`/`item_id` is part of the request and the item has a default currency then `currencies` is optional. If the item does not have a default currency, then `currencies` is required. If `item_code`/`item_id` is not present `currencies` is required.
      define_attribute :currencies, Array, { :item_type => :AddOnPricing }

      # @!attribute default_quantity
      #   @return [Integer] Default quantity for the hosted pages.
      define_attribute :default_quantity, Integer

      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the add-on.
      define_attribute :display_quantity, :Boolean

      # @!attribute item_code
      #   @return [String] Unique code to identify an item. Avaliable when the `Catalog: Item Add-Ons` feature is enabled. If `item_id` and `item_code` are both present, `item_id` will be used.
      define_attribute :item_code, String

      # @!attribute item_id
      #   @return [String] System-generated unique identifier for an item. Available when the `Catalog: Item Add-Ons` feature is enabled. If `item_id` and `item_code` are both present, `item_id` will be used.
      define_attribute :item_id, String

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices. If `item_code`/`item_id` is part of the request then `name` must be absent. If `item_code`/`item_id` is not present `name` is required.
      define_attribute :name, String

      # @!attribute plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String

      # @!attribute revenue_schedule_type
      #   @return [String] When this add-on is invoiced, the line item will use this revenue schedule. If `item_code`/`item_id` is part of the request then `revenue_schedule_type` must be absent in the request as the value will be set from the item.
      define_attribute :revenue_schedule_type, String

      # @!attribute tax_code
      #   @return [String] Optional field used by Avalara, Vertex, and Recurly's EU VAT tax feature to determine taxation rules. If you have your own AvaTax or Vertex account configured, use their tax codes to assign specific tax rules. If you are using Recurly's EU VAT feature, you can use values of `unknown`, `physical`, or `digital`. If `item_code`/`item_id` is part of the request then `tax_code` must be absent.
      define_attribute :tax_code, String
    end
  end
end

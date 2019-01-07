# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please file a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PlanCreate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for the plan. If no value is provided, it defaults to plan's code.
      define_attribute :accounting_code, String

      # @!attribute add_ons
      #   @return [Array[AddOnCreate]] Add Ons
      define_attribute :add_ons, Array, {:item_type => :AddOnCreate}

      # @!attribute auto_renew
      #   @return [Boolean] Subscriptions will automatically inherit this value once they are active. If `auto_renew` is `true`, then a subscription will automatically renew its term at renewal. If `auto_renew` is `false`, then a subscription will expire at the end of its term. `auto_renew` can be overridden on the subscription record itself.
      define_attribute :auto_renew, :Boolean

      # @!attribute code
      #   @return [String] Unique code to identify the plan. This is used in Hosted Payment Page URLs and in the invoice exports.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[PlanPricing]] Pricing
      define_attribute :currencies, Array, {:item_type => :PlanPricing}

      # @!attribute description
      #   @return [String] Optional description, not displayed.
      define_attribute :description, String

      # @!attribute hosted_pages
      #   @return [Hash] Hosted pages settings
      define_attribute :hosted_pages, Hash

      # @!attribute interval_length
      #   @return [Integer] Length of the plan's billing interval in `interval_unit`.
      define_attribute :interval_length, Integer

      # @!attribute interval_unit
      #   @return [String] Unit for the plan's billing interval.
      define_attribute :interval_unit, String, {:enum => ["days", "months"]}

      # @!attribute name
      #   @return [String] This name describes your plan and will appear on the Hosted Payment Page and the subscriber's invoice.
      define_attribute :name, String

      # @!attribute setup_fee_accounting_code
      #   @return [String] Accounting code for invoice line items for the plan's setup fee. If no value is provided, it defaults to plan's accounting code.
      define_attribute :setup_fee_accounting_code, String

      # @!attribute tax_code
      #   @return [String] Optional field for EU VAT merchants and Avalara AvaTax Pro merchants. If you are using Recurly's EU VAT feature, you can use values of 'unknown', 'physical', or 'digital'. If you have your own AvaTax account configured, you can use Avalara tax codes to assign custom tax rules.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on the plan, `false` applies tax on the plan.
      define_attribute :tax_exempt, :Boolean

      # @!attribute total_billing_cycles
      #   @return [Integer] Automatically terminate plans after a defined number of billing cycles.
      define_attribute :total_billing_cycles, Integer

      # @!attribute trial_length
      #   @return [Integer] Length of plan's trial period in `trial_units`. `0` means `no trial`.
      define_attribute :trial_length, Integer

      # @!attribute trial_unit
      #   @return [String] Units for the plan's trial period.
      define_attribute :trial_unit, String, {:enum => ["days", "months"]}
    end
  end
end

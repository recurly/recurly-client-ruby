# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Plan < Resource

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for the plan. If no value is provided, it defaults to plan's code.
      define_attribute :accounting_code, String

      # @!attribute code
      #   @return [String] Unique code to identify the plan. This is used in Hosted Payment Page URLs and in the invoice exports.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currencies
      #   @return [Array[Hash]] Pricing
      define_attribute :currencies, Array, { :item_type => Hash }

      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime

      # @!attribute description
      #   @return [String] Optional description, not displayed.
      define_attribute :description, String

      # @!attribute hosted_pages
      #   @return [PlanHostedPages] Hosted pages settings
      define_attribute :hosted_pages, :PlanHostedPages

      # @!attribute id
      #   @return [String] Plan ID
      define_attribute :id, String

      # @!attribute interval_length
      #   @return [Integer] Length of the plan's billing interval in `interval_unit`.
      define_attribute :interval_length, Integer

      # @!attribute interval_unit
      #   @return [String] Unit for the plan's billing interval.
      define_attribute :interval_unit, String

      # @!attribute name
      #   @return [String] This name describes your plan and will appear on the Hosted Payment Page and the subscriber's invoice.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute setup_fee_accounting_code
      #   @return [String] Accounting code for invoice line items for the plan's setup fee. If no value is provided, it defaults to plan's accounting code.
      define_attribute :setup_fee_accounting_code, String

      # @!attribute state
      #   @return [String] The current state of the plan.
      define_attribute :state, String

      # @!attribute tax_code
      #   @return [String] Used by Avalara, Vertex, and Recurly’s EU VAT tax feature. The tax code values are specific to each tax system. If you are using Recurly’s EU VAT feature `P0000000` is `physical`, `D0000000` is `digital`, and an empty string is `unknown`.
      define_attribute :tax_code, String

      # @!attribute tax_exempt
      #   @return [Boolean] `true` exempts tax on the plan, `false` applies tax on the plan.
      define_attribute :tax_exempt, :Boolean

      # @!attribute total_billing_cycles
      #   @return [Integer] Automatically terminate subscriptions after a defined number of billing cycles. Number of billing cycles before the plan automatically stops renewing, defaults to `null` for continuous, automatic renewal.
      define_attribute :total_billing_cycles, Integer

      # @!attribute trial_length
      #   @return [Integer] Length of plan's trial period in `trial_units`. `0` means `no trial`.
      define_attribute :trial_length, Integer

      # @!attribute trial_unit
      #   @return [String] Units for the plan's trial period.
      define_attribute :trial_unit, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

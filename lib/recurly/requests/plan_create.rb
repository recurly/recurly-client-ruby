# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PlanCreate < Request

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for the plan. If no value is provided, it defaults to plan's code.
      define_attribute :accounting_code, String

      # @!attribute add_ons
      #   @return [Array[AddOnCreate]] Add Ons
      define_attribute :add_ons, Array, { :item_type => :AddOnCreate }

      # @!attribute allow_any_item_on_subscriptions
      #   @return [Boolean] Used to determine whether items can be assigned as add-ons to individual subscriptions. If `true`, items can be assigned as add-ons to individual subscription add-ons. If `false`, only plan add-ons can be used.
      define_attribute :allow_any_item_on_subscriptions, :Boolean

      # @!attribute auto_renew
      #   @return [Boolean] Subscriptions will automatically inherit this value once they are active. If `auto_renew` is `true`, then a subscription will automatically renew its term at renewal. If `auto_renew` is `false`, then a subscription will expire at the end of its term. `auto_renew` can be overridden on the subscription record itself.
      define_attribute :auto_renew, :Boolean

      # @!attribute avalara_service_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the plan is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_service_type, Integer

      # @!attribute avalara_transaction_type
      #   @return [Integer] Used by Avalara for Communications taxes. The transaction type in combination with the service type describe how the plan is taxed. Refer to [the documentation](https://help.avalara.com/AvaTax_for_Communications/Tax_Calculation/AvaTax_for_Communications_Tax_Engine/Mapping_Resources/TM_00115_AFC_Modules_Corresponding_Transaction_Types) for more available t/s types.
      define_attribute :avalara_transaction_type, Integer

      # @!attribute code
      #   @return [String] Unique code to identify the plan. This is used in Hosted Payment Page URLs and in the invoice exports.
      define_attribute :code, String

      # @!attribute currencies
      #   @return [Array[PlanPricing]] Required only when `pricing_model` is `'fixed'`.
      define_attribute :currencies, Array, { :item_type => :PlanPricing }

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute description
      #   @return [String] Optional description, not displayed.
      define_attribute :description, String

      # @!attribute dunning_campaign_id
      #   @return [String] Unique ID to identify a dunning campaign. Used to specify if a non-default dunning campaign should be assigned to this plan. For sites without multiple dunning campaigns enabled, the default dunning campaign will always be used.
      define_attribute :dunning_campaign_id, String

      # @!attribute hosted_pages
      #   @return [PlanHostedPages] Hosted pages settings
      define_attribute :hosted_pages, :PlanHostedPages

      # @!attribute interval_length
      #   @return [Integer] Length of the plan's billing interval in `interval_unit`.
      define_attribute :interval_length, Integer

      # @!attribute interval_unit
      #   @return [String] Unit for the plan's billing interval.
      define_attribute :interval_unit, String

      # @!attribute liability_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :liability_gl_account_id, String

      # @!attribute name
      #   @return [String] This name describes your plan and will appear on the Hosted Payment Page and the subscriber's invoice.
      define_attribute :name, String

      # @!attribute performance_obligation_id
      #   @return [String] The ID of a performance obligation. Performance obligations are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :performance_obligation_id, String

      # @!attribute pricing_model
      #   @return [String] A fixed pricing model has the same price for each billing period. A ramp pricing model defines a set of Ramp Intervals, where a subscription changes price on a specified cadence of billing periods. The price change could be an increase or decrease.
      define_attribute :pricing_model, String

      # @!attribute ramp_intervals
      #   @return [Array[PlanRampInterval]] Ramp Intervals
      define_attribute :ramp_intervals, Array, { :item_type => :PlanRampInterval }

      # @!attribute revenue_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :revenue_gl_account_id, String

      # @!attribute revenue_schedule_type
      #   @return [String] Revenue schedule type
      define_attribute :revenue_schedule_type, String

      # @!attribute setup_fee_accounting_code
      #   @return [String] Accounting code for invoice line items for the plan's setup fee. If no value is provided, it defaults to plan's accounting code.
      define_attribute :setup_fee_accounting_code, String

      # @!attribute setup_fee_liability_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :setup_fee_liability_gl_account_id, String

      # @!attribute setup_fee_performance_obligation_id
      #   @return [String] The ID of a performance obligation. Performance obligations are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :setup_fee_performance_obligation_id, String

      # @!attribute setup_fee_revenue_gl_account_id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :setup_fee_revenue_gl_account_id, String

      # @!attribute setup_fee_revenue_schedule_type
      #   @return [String] Setup fee revenue schedule type
      define_attribute :setup_fee_revenue_schedule_type, String

      # @!attribute setup_fees
      #   @return [Array[PlanSetupPricingCreate]] Setup Fees
      define_attribute :setup_fees, Array, { :item_type => :PlanSetupPricingCreate }

      # @!attribute tax_code
      #   @return [String] Optional field used by Avalara, Vertex, and Recurly's In-the-Box tax solution to determine taxation rules. You can pass in specific tax codes using any of these tax integrations. For Recurly's In-the-Box tax offering you can also choose to instead use simple values of `unknown`, `physical`, or `digital` tax codes.
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

      # @!attribute trial_requires_billing_info
      #   @return [Boolean] Allow free trial subscriptions to be created without billing info. Should not be used if billing info is needed for initial invoice due to existing uninvoiced charges or setup fee.
      define_attribute :trial_requires_billing_info, :Boolean

      # @!attribute trial_unit
      #   @return [String] Units for the plan's trial period.
      define_attribute :trial_unit, String

      # @!attribute vertex_transaction_type
      #   @return [String] Used by Vertex for tax calculations. Possible values are `sale`, `rental`, `lease`.
      define_attribute :vertex_transaction_type, String
    end
  end
end

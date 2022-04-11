module Recurly
  class AddOn < Resource
    # @return [Plan]
    belongs_to :plan
    # @return [[Tier], []]
    has_many :tiers, class_name: :Tier, readonly: false
    # @return [[PercentageTier], []]
    has_many :percentage_tiers, class_name: :CurrencyPercentageTier, readonly: false

    define_attribute_methods %w(
      add_on_code
      item_code
      name
      item_state
      accounting_code
      default_quantity
      unit_amount_in_cents
      display_quantity_on_hosted_page
      tax_code
      add_on_type
      measured_unit_id
      optional
      usage_type
      usage_percentage
      revenue_schedule_type
      created_at
      updated_at
      tier_type
      usage_timeframe
      external_sku
      avalara_service_type
      avalara_transaction_type
    )
    alias to_param add_on_code
    alias quantity default_quantity

    def changed_attributes
      attrs = super
      if tiers.any?(&:changed?)
        attrs['tiers'] = tiers.select(&:changed?)
      elsif percentage_tiers.any?(&:changed?)
        attrs['percentage_tiers'] = percentage_tiers.select(&:changed?)
      end
      attrs
    end

    # Add-ons are only writeable and readable through {Plan} instances.
    embedded!
    private_class_method :find
  end
end

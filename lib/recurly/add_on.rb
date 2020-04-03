module Recurly
  class AddOn < Resource
    # @return [Plan]
    belongs_to :plan
    has_many :tiers, class_name: :Tier, readonly: false

    define_attribute_methods %w(
      add_on_code
      item_code
      name
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
    )
    alias to_param add_on_code
    alias quantity default_quantity

    def changed_attributes
      attrs = super
      if tiers.any?(&:changed?)
        attrs['tiers'] = tiers.select(&:changed?)
      end
      attrs
    end

    # Add-ons are only writeable and readable through {Plan} instances.
    embedded!
    private_class_method :find
  end
end

module Recurly
  class SubscriptionAddOn < Resource
    # @return [MeasuredUnit]
    has_one :measured_unit

    # @return [Pager<Usage>, []]
    has_many :usage

    # @return [[Tier], []]
    has_many :tiers, class_name: :Tier, readonly: false

    # @return [[PercentageTier], []]
    has_many :percentage_tiers, class_name: :SubAddOnPercentageTier, readonly: false

    define_attribute_methods %w(
      add_on_code
      quantity
      unit_amount_in_cents
      add_on_type
      usage_type
      usage_percentage
      usage_timeframe
      usage_calculation_type
      add_on_source
    )

    attr_reader :subscription

    def initialize add_on = nil, subscription = nil
      super()

      case add_on
      when AddOn, SubscriptionAddOn
        @add_on = add_on if add_on.is_a? AddOn
        self.add_on_code = add_on.add_on_code
        self.quantity = add_on.quantity
        if add_on.unit_amount_in_cents
          self.unit_amount_in_cents = add_on.unit_amount_in_cents.to_i
        end
        if add_on.respond_to? :add_on_source
          self.add_on_source = add_on.add_on_source
        end
        self.tiers = add_on.tiers if add_on.tiers.any?
        self.percentage_tiers = add_on.percentage_tiers if add_on.percentage_tiers.any?
      when Hash
        self.attributes = add_on
      when String, Symbol
        self.add_on_code = add_on
      end

      self.add_on_code = add_on_code.to_s

      @subscription = subscription
    end

    def add_on
      @add_on ||= subscription.plan.add_ons.find add_on_code
    end

    def currency
      subscription.currency if subscription
    end
  end
end

module Recurly
  class SubscriptionAddOn < Resource
    define_attribute_methods %w(
      add_on_code
      quantity
      unit_amount_in_cents
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

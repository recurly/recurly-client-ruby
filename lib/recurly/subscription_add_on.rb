module Recurly
  class SubscriptionAddOn < Resource
    define_attribute_methods %w(
      add_on_code
      quantity
      unit_amount_in_cents
    )

    def initialize add_on = nil
      super()

      case add_on
      when AddOn, SubscriptionAddOn
        self.add_on_code = add_on.add_on_code
        self.quantity = add_on.quantity
        self.unit_amount_in_cents = add_on.unit_amount_in_cents
      when Hash
        self.attributes = add_on
      when String, Symbol
        self.add_on_code = add_on
      end

      self.add_on_code = add_on_code.to_s
    end
  end
end

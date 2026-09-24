# frozen_string_literal: true

module Recurly
  # Represents a ShippingMethod in Recurly
  class ShippingMethod < Recurly::Model
    def self.list(params:)
      client.list_shipping_methods(params: params)
    end

    def self.get(id:)
      client.get_shipping_method(shipping_method_id: id)
    end
  end
end

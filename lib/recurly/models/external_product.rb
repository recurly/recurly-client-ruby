# frozen_string_literal: true

module Recurly
  # Represents a ExternalProduct in Recurly
  class ExternalProduct < Recurly::Model
    def self.list(params:)
      client.list_external_products(params: params)
    end

    def self.get(id:)
      client.get_external_product(external_product_id: id)
    end
  end
end

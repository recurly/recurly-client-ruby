# frozen_string_literal: true

module Recurly
  # Represents a BusinessEntity in Recurly
  class BusinessEntity < Recurly::Model
    def self.list(params:)
      client.list_business_entities(params: params)
    end

    def self.get(id:)
      client.get_business_entity(business_entity_id: id)
    end
  end
end

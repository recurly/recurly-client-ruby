# frozen_string_literal: true

module Recurly
  # Represents a AddOn in Recurly
  class AddOn < Recurly::Model
    def self.list(params:)
      client.list_add_ons(params: params)
    end

    def self.get(id:)
      client.get_add_on(add_on_id: id)
    end
  end
end

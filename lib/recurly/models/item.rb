# frozen_string_literal: true

module Recurly
  # Represents a Item in Recurly
  class Item < Recurly::Model
    def self.list(params:)
      client.list_items(params: params)
    end

    def self.get(id:)
      client.get_item(item_id: id)
    end
  end
end

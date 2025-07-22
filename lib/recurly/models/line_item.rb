# frozen_string_literal: true

module Recurly
  # Represents a LineItem in Recurly
  class LineItem < Recurly::Model
    def self.list(params:)
      client.list_line_items(params: params)
    end

    def self.get(id:)
      client.get_line_item(line_item_id: id)
    end
  end
end

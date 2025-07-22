# frozen_string_literal: true

module Recurly
  # Represents a GiftCard in Recurly
  class GiftCard < Recurly::Model
    def self.list(params:)
      client.list_gift_cards(params: params)
    end

    def self.get(id:)
      client.get_gift_card(gift_card_id: id)
    end
  end
end

# frozen_string_literal: true

module Recurly
  # Represents a Transaction in Recurly
  class Transaction < Recurly::Model
    def self.list(params:)
      client.list_transactions(params: params)
    end

    def self.get(id:)
      client.get_transaction(transaction_id: id)
    end
  end
end

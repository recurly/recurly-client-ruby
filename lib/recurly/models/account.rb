# frozen_string_literal: true

module Recurly
  # Represents an Account in Recurly
  class Account < Recurly::Model
    def self.list(params:)
      p "Listing accounts with params: #{params.inspect}"
      client.list_accounts(params: params)
    end

    def self.get(id:)
      client.get_account(account_id: id)
    end
  end
end

# frozen_string_literal: true

module Recurly
  # Represents a GeneralLedgerAccount in Recurly
  class GeneralLedgerAccount < Recurly::Model
    def self.list(params:)
      client.list_general_ledger_accounts(params: params)
    end

    def self.get(id:)
      client.get_general_ledger_account(general_ledger_account_id: id)
    end
  end
end

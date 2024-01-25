module Recurly
  class GeneralLedgerAccount < Resource
    belongs_to :site

    define_attribute_methods %w(
      id
      code
      description
      account_type
    )

    def self.collection_path
      "general_ledger_accounts"
    end
  end
end

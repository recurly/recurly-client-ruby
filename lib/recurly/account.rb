module Recurly
  class Account < RecurlyBase
    self.element_name = "account"
    self.primary_key = :account_code

    def close_account
      destroy
    end
  end
end
module Recurly
  class Account < RecurlyBase
    self.element_name = "account"
    self.primary_key = :account_code

    def close_account
      destroy
    end

    def charges
      Charge.list(account_code)
    end

    def lookup_charge(id)
      Charge.lookup(account_code, id)
    end

    def credits
      Credit.list(account_code)
    end

    def lookup_credit(id)
      Credit.lookup(account_code, id)
    end

  end
end
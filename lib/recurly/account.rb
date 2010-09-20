module Recurly
  class Account < RecurlyBase
    self.element_name = "account"
    self.primary_key = :account_code

    LIST_PARAMS = {
      :active => {:show => "active_subscribers"},
      :pastdue => {:show => "pastdue_subscribers"},
      :free => {:show => "non_subscribers"}
    }

    # Lists all accounts (with optional filter)
    #   Account.list(:all) #=> returns all accounts
    #   Account.list(:active) #=> returns active accounts
    #   Account.list(:pastdue) #=> returns pastdue accounts
    #   Account.list(:free) #=> returns the free accounts
    def self.list(status = :all)
      opts = {}
      if status != :all
        opts[:params] = LIST_PARAMS[status]
      end
      find(:all, opts)
    end

    def close_account
      destroy
    end

    def charges
      Charge.list(account_code)
    end
    memoize :charges

    def lookup_charge(id)
      Charge.lookup(account_code, id)
    end

    def credits
      Credit.list(account_code)
    end
    memoize :credits

    def lookup_credit(id)
      Credit.lookup(account_code, id)
    end

    def transactions(status)
      Transaction.list(account_code, status)
    end
    memoize :transactions

    def lookup_transaction(id)
      Transaction.lookup(account_code, id)
    end

    def invoices
      Invoice.list(account_code)
    end
    memoize :invoices

    def lookup_invoice(id)
      Invoice.lookup(account_code, id)
    end

  end
end
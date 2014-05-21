module Recurly
  class Account < Base
    self.element_name = "account"
    self.primary_key = :account_code

    # known attributes for a recurly account
    def self.known_attributes
      [
        "account_code",
        "username",
        "first_name",
        "last_name",
        "email",
        "company_name",
        "hosted_login_token",
        "accept_language"
      ]
    end

    # initialize associations
    def initialize(attributes = {}, persisted = false)
      attributes = attributes.with_indifferent_access
      attributes[:billing_info] ||= {}
      super
    end

    attr_accessor :account_code_was
    def account_code=(new_account_code)
      self.account_code_was = self.account_code
      super
    end

    def to_param
      account_code_was || account_code
    end

    def encode(options={})
      attributes[:accept_language] ||= Recurly.current_accept_language
      super
    end

    # Maps the
    SHOW_PARAMS = {
      :active => "active_subscribers",
      :pastdue => "pastdue_subscribers",
      :free => "non_subscribers"
    }

    # Lists all accounts (with optional filter)
    # This method also accepts a Hash that allows you to specify a page number, etc.
    #
    # examples:
    #   Account.list(:all) #=> returns all accounts
    #   Account.list(:active) #=> returns active accounts
    #   Account.list(:pastdue) #=> returns pastdue accounts
    #   Account.list(:free) #=> returns the free accounts
    #   Account.list(:active, {:page => 3}) #=> returns the 3rd page of active accounts
    #
    def self.list(status = :all, params = {})
      opts = {:params => params}

      if status && status != :all
        params[:show] = SHOW_PARAMS[status] || status
      end
      find(:all, opts)
    end

    def close_account
      destroy
    end

    def charges(status = :all)
      @_charges ||= Charge.list(account_code, status)
    end

    def lookup_charge(id)
      Charge.lookup(account_code, id)
    end

    def credits
      @_credits ||= Credit.list(account_code)
    end

    def lookup_credit(id)
      Credit.lookup(account_code, id)
    end

    def transactions(status)
      @_transactions ||= Transaction.list_for_account(account_code, status)
    end

    def lookup_transaction(id)
      Transaction.lookup(account_code, id)
    end

    def invoices
      @_invoices ||= Invoice.list(account_code)
    end

    def lookup_invoice(id)
      Invoice.lookup(account_code, id)
    end

    def coupon
      @_coupons ||= Coupon.find(account_code)
    end
  end
end

module Recurly
  class Transaction < RecurlyBase
    self.element_name = "transaction"


    def self.list(status = :all)

      options = {}
      if status != :all
        options[:params] = {:show => status.to_s}
      end

      find(:all, options)
    end

    def self.list_for_account(account_code, status = :all)
      results = find(:all, :from => "/accounts/#{CGI::escape(account_code.to_s)}/transactions")

      # filter by status
      if status != :all
        results = results.select{|t| t.status == status.to_s }
      end

      results
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

    def void
      connection.delete(element_path(:action => "void"), self.class.headers)
    end

    def refund(amount_in_cents)
      connection.delete(element_path(:action => "refund", :amount => amount_in_cents), self.class.headers)
    end

  end
end
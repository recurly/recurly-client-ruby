module Recurly
  class Transaction < RecurlyBase
    self.element_name = "transaction"

    def self.list(account_code, status = :all)
      results = find(:all, :from => "/accounts/#{CGI::escape(account_code || '')}/transactions")

      # filter by status
      if status != :all
        results = results.select{|t| t.status == status.to_s }
      end

      results
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

  end
end
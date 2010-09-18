module Recurly
  class Transaction < RecurlyBase
    self.element_name = "transaction"

    def self.list(account_code)
      find(:all, :from => "/accounts/#{CGI::escape(account_code || '')}/transactions")
    end

  end
end
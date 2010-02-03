module Recurly
  class Invoice < RecurlyBase
    self.element_name = "invoice"
  
    def self.list(account_code)
      Invoice.find(:all, :from => "/accounts/#{account_code}/invoices")
    end
  end
end
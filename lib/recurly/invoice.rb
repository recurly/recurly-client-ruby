module Recurly
  class Invoice < RecurlyBase
    self.element_name = "invoice"
    self.prefix = "/accounts/:account_code/"

    def self.list(account_code)
      Invoice.find(:all)
    end
  end
end
module Recurly
  class Credit < RecurlyBase
    self.element_name = "credit"
    self.prefix = "/accounts/:account_code/"
  
    def self.list(account_code)
      Credit.find(:all, :params => { :account_code => account_code })
    end
  end
end
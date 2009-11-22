module Recurly
  class Charge < RecurlyBase
    self.element_name = "charge"
    self.prefix = "/accounts/:account_code/"
  
    def self.list(account_code)
      Charge.find(:all, :params => { :account_code => account_code })
    end
  end
end
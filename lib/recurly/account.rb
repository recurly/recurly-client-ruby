module Recurly
  class Account < RecurlyBase
    self.element_name = "account"
    
    def close_account
      destroy
    end
    
    def primary_key
      self.account_code
    end
    
    def to_param
      self.account_code
    end
  end
end
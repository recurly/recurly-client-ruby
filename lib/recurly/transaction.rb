module Recurly
  class Transaction < RecurlyBase
    self.element_name = "transaction"
    self.prefix = "/"  
  end
end
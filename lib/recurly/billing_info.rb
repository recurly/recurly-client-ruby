module Recurly
  class BillingInfo < RecurlySingularResourceBase
    self.element_name = "billing_info"
    self.prefix = "/accounts/:account_code"
    
    def update_only
      true
    end
  end
end
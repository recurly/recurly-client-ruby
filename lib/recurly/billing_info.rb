module Recurly
  class BillingInfo < RecurlySingularResourceBase
    self.element_name = "billing_info"
    self.prefix = "/accounts/:account_code"
    
    # Create / Update is always a PUT
    def save
      update
    end
  end
end
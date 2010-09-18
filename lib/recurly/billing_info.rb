module Recurly
  class BillingInfo < RecurlyAccountBase
    self.element_name = "billing_info"

    def update_only
      true
    end
  end
end
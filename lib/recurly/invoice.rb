module Recurly
  class Invoice < RecurlyBase
    self.element_name = "invoice"
    self.prefix = "/accounts/:account_code/"

    def self.list(account_code)
      Invoice.find(:all)
    end

    # do we need to customize the element path for singular lookups?
    # def self.element_path(options = {})
    #   ""
    # end
  end
end
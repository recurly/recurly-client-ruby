module Recurly
  class Invoice < RecurlyBase
    self.element_name = "invoice"
    self.prefix = "/accounts/:account_code/"

    def self.list(account_code)
      find(:all, :params => { :account_code => account_code })
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

    def self.element_path(id, prefix_options = {}, query_options = nil)
      path = super

      # postprocess generated element url.
      # changes /accounts/:account_code/invoices/:id to /invoices/:id
      # this breaks update, however I dont believe recurly allows invoice updates anyways
      path.sub("/accounts/#{CGI::escape(prefix_options[:account_code].to_s)}/invoices/", "/invoices/")
    end

  end
end
module Recurly
  class Charge < RecurlyBase
    self.element_name = "charge"
    self.prefix = "/accounts/:account_code/"

    def self.list(account_code, status = :all)
      params = {:account_code => account_code}

      if status != :all
        params[:show] = status.to_s
      end

      find(:all, :params => params)
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

    # def destroy
    #   reload
    #   return false if respond_to?(:invoice_id) and invoice_id.present?
    #   super
    # end
  end
end
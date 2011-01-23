module Recurly
  class Credit < Base
    self.element_name = "credit"
    self.prefix = "/accounts/:account_code/"

    # initialize fields with blank data
    def initialize(attributes = {})

      attributes[:account_code] ||= nil
      attributes[:amount_in_cents] ||= nil
      attributes[:end_date] ||= nil
      attributes[:description] ||= nil

      super(attributes)
    end

    def self.list(account_code)
      find(:all, :params => { :account_code => account_code })
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

  end
end
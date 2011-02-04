module Recurly
  class Credit < Base
    self.element_name = "credit"
    self.prefix = "/accounts/:account_code/"

    def self.known_attributes
      [
        "account_code",
        "amount_in_cents",
        "start_date",
        "end_date",
        "description",
        "created_at"
      ]
    end

    def self.list(account_code)
      find(:all, :params => { :account_code => account_code })
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

  end
end
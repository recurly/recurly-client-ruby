module Recurly
  class Transaction < Base
    self.element_name = "transaction"

    def self.known_attributes
      [
        "description",
        "amount_in_cents",
        "account_code",
        "type",
        "action",
        "date",
        "status",
        "message",
        "reference",
        "ccv_result",
        "avs_result",
        "avs_result_street",
        "avs_result_postal",
        "test",
        "voidable",
        "refundable"
      ]
    end

    # initialize fields with blank data
    def initialize(attributes = {})
      # initialize embedded attributes
      attributes = attributes.with_indifferent_access
      attributes[:account] ||= {}
      super(attributes)
    end

    def self.list(status = :all)

      options = {}
      if status != :all
        options[:params] = {:show => status.to_s}
      end

      find(:all, options)
    end

    def self.list_for_account(account_code, status = :all)
      results = find(:all, :from => "/accounts/#{CGI::escape(account_code.to_s)}/transactions")

      # filter by status
      if status != :all
        results = results.select{|t| t.status == status.to_s }
      end

      results
    end

    def self.lookup(account_code, id)
      find(id, :params => { :account_code => account_code })
    end

    def void
      connection.delete(element_path(:action => "void"), self.class.headers)
    end

    def refund(amount)
      connection.delete(element_path(:action => "refund", :amount => amount), self.class.headers)
    end

  end
end
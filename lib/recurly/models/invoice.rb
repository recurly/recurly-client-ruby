# frozen_string_literal: true

module Recurly
  # Represents a Invoice in Recurly
  class Invoice < Recurly::Model
    def self.list(params:)
      client.list_invoices(params: params)
    end

    def self.get(id:)
      client.get_invoice(invoice_id: id)
    end
  end
end

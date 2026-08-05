# frozen_string_literal: true

module Recurly
  # Represents a ExternalInvoice in Recurly
  class ExternalInvoice < Recurly::Model
    def self.list(params:)
      client.list_external_invoices(params: params)
    end

    def self.get(id:)
      client.show_external_invoice(external_invoice_id: id)
    end
  end
end

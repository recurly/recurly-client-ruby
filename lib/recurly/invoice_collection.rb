module Recurly
  class InvoiceCollection < Resource
    # @return [Invoice, nil]
    has_one :charge_invoice, class_name: :Invoice, readonly: true

    # @return [[Invoice], []]
    has_many :credit_invoices, class_name: :Invoice, readonly: true

    # These are readonly resources
    embedded! true
    undef save
    undef destroy
  end
end

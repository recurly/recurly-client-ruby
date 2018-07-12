module Recurly
  module Resources
    class InvoiceCollection < Resource

      # @!attribute charge_invoice
      #   @return [Invoice]
      define_attribute :charge_invoice, :Invoice

      # @!attribute credit_invoices
      #   @return [Array[Invoice]] Credit invoices
      define_attribute :credit_invoices, Array, {:item_type => :Invoice}

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
    end
  end
end

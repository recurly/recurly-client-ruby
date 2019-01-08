# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
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

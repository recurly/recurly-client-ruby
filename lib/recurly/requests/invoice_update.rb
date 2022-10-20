# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class InvoiceUpdate < Request
      
      # @!attribute address
      #   @return [InvoiceAddress] 
      define_attribute :address, :InvoiceAddress
      
      # @!attribute customer_notes
      #   @return [String] Customer notes are an optional note field.
      define_attribute :customer_notes, String
      
      # @!attribute net_terms
      #   @return [Integer] Integer representing the number of days after an invoice's creation that the invoice will become past due. Changing Net terms changes due_on, and the invoice could move between past due and pending.
      define_attribute :net_terms, Integer
      
      # @!attribute po_number
      #   @return [String] This identifies the PO number associated with the invoice. Not editable for credit invoices.
      define_attribute :po_number, String
      
      # @!attribute terms_and_conditions
      #   @return [String] Terms and conditions are an optional note field. Not editable for credit invoices.
      define_attribute :terms_and_conditions, String
      
      # @!attribute vat_reverse_charge_notes
      #   @return [String] VAT Reverse Charge Notes are editable only if there was a VAT reverse charge applied to the invoice.
      define_attribute :vat_reverse_charge_notes, String
      
    end
  end
end

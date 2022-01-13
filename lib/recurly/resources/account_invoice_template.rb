# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountInvoiceTemplate < Resource

      # @!attribute id
      #   @return [String] Unique ID to identify the invoice template.
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Template name
      define_attribute :name, String
    end
  end
end

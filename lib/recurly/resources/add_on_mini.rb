# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AddOnMini < Resource

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for this add-on. If no value is provided, it defaults to add-on's code.
      define_attribute :accounting_code, String

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan.
      define_attribute :code, String

      # @!attribute [r] id
      #   @return [String] Add-on ID
      define_attribute :id, String, { :read_only => true }

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices.
      define_attribute :name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }
    end
  end
end

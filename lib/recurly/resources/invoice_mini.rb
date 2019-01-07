# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please file a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class InvoiceMini < Resource

      # @!attribute id
      #   @return [String] Invoice ID
      define_attribute :id, String

      # @!attribute number
      #   @return [String] Invoice number
      define_attribute :number, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute state
      #   @return [String] Invoice state
      define_attribute :state, String, {:enum => ["pending", "processing", "past_due", "paid", "failed"]}

      # @!attribute type
      #   @return [String] Invoice type
      define_attribute :type, String, {:enum => ["charge", "credit", "legacy"]}
    end
  end
end

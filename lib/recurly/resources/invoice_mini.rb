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

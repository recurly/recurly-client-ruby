# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalTransaction < Request

      # @!attribute amount
      #   @return [Float] The total amount of the transcaction. Cannot excceed the invoice total.
      define_attribute :amount, Float

      # @!attribute collected_at
      #   @return [DateTime] Datetime that the external payment was collected. Defaults to current datetime.
      define_attribute :collected_at, DateTime

      # @!attribute description
      #   @return [String] Used as the transaction's description.
      define_attribute :description, String

      # @!attribute payment_method
      #   @return [String] Payment method used for external transaction.
      define_attribute :payment_method, String
    end
  end
end

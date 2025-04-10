# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalInvoiceCreate < Request

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute external_id
      #   @return [String] An identifier which associates the external invoice to a corresponding object in an external platform.
      define_attribute :external_id, String

      # @!attribute external_payment_phase
      #   @return [ExternalPaymentPhaseBase]
      define_attribute :external_payment_phase, :ExternalPaymentPhaseBase

      # @!attribute external_payment_phase_id
      #   @return [String] External payment phase ID, e.g. `a34ypb2ef9w1`.
      define_attribute :external_payment_phase_id, String

      # @!attribute line_items
      #   @return [Array[ExternalChargeCreate]]
      define_attribute :line_items, Array, { :item_type => :ExternalChargeCreate }

      # @!attribute purchased_at
      #   @return [DateTime] When the invoice was created in the external platform.
      define_attribute :purchased_at, DateTime

      # @!attribute state
      #   @return [String]
      define_attribute :state, String

      # @!attribute total
      #   @return [String]
      define_attribute :total, String
    end
  end
end

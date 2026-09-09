# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryInvoiceCreate < Request

      # @!attribute account
      #   @return [RecoveryAccountCreate]
      define_attribute :account, :RecoveryAccountCreate

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute due_at
      #   @return [DateTime] Date invoice was originally due. Must be in the past.
      define_attribute :due_at, DateTime

      # @!attribute external_recovery_eligible
      #   @return [Boolean] Must be set to `true` to acknowledge that the invoice is eligible for external recovery. Requests with `false`, omitted, or non-boolean values will be rejected.
      define_attribute :external_recovery_eligible, :Boolean

      # @!attribute line_items
      #   @return [Array[RecoveryLineItemCreate]] Line items to include on the invoice. Currency is specified at the root level and must not be included in individual line items.
      define_attribute :line_items, Array, { :item_type => :RecoveryLineItemCreate }

      # @!attribute po_number
      #   @return [String] This identifies the PO number associated with the subscription.
      define_attribute :po_number, String

      # @!attribute transaction_descriptor_suffix
      #   @return [String] Optionally overrides the suffix component of the composed transaction descriptor. If omitted, the suffix is derived from the subscription's plan name or the invoice description, with a Trial prefix on Visa trial conversions. Subject to gateway availability and payment method support.
      define_attribute :transaction_descriptor_suffix, String
    end
  end
end

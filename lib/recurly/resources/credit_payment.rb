# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CreditPayment < Resource

      # @!attribute account
      #   @return [AccountMini]
      define_attribute :account, :AccountMini

      # @!attribute action
      #   @return [String] The action for which the credit was created.
      define_attribute :action, String

      # @!attribute amount
      #   @return [Float] Total credit payment amount applied to the charge invoice.
      define_attribute :amount, Float

      # @!attribute applied_to_invoice
      #   @return [InvoiceMini]
      define_attribute :applied_to_invoice, :InvoiceMini

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute id
      #   @return [String] Credit Payment ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute original_invoice
      #   @return [InvoiceMini]
      define_attribute :original_invoice, :InvoiceMini

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime

      # @!attribute uuid
      #   @return [String] The UUID is useful for matching data with the CSV exports and building URLs into Recurly's UI.
      define_attribute :uuid, String

      # @!attribute voided_at
      #   @return [DateTime] Voided at
      define_attribute :voided_at, DateTime
    end
  end
end

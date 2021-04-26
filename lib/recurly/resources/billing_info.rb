# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class BillingInfo < Resource

      # @!attribute account_id
      #   @return [String]
      define_attribute :account_id, String

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute backup_payment_method
      #   @return [Boolean] The `backup_payment_method` indicator is used to designate a billing info as a backup on the account that will be tried if the billing info marked `primary_payment_method` fails.
      define_attribute :backup_payment_method, :Boolean

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute created_at
      #   @return [DateTime] When the billing information was created.
      define_attribute :created_at, DateTime

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute fraud
      #   @return [FraudInfo] Most recent fraud result.
      define_attribute :fraud, :FraudInfo

      # @!attribute id
      #   @return [String]
      define_attribute :id, String

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute payment_method
      #   @return [PaymentMethod]
      define_attribute :payment_method, :PaymentMethod

      # @!attribute primary_payment_method
      #   @return [Boolean] The `primary_payment_method` indicator is used to designate the primary billing info on the account. The first billing info created on an account will always become primary. Adding additional billing infos provides the flexibility to mark another billing info as primary, or adding additional non-primary billing infos. This can be accomplished by passing the `primary_payment_method` indicator. When adding billing infos via the billing_info and /accounts endpoints, this value is not permitted, and will return an error if provided.
      define_attribute :primary_payment_method, :Boolean

      # @!attribute updated_at
      #   @return [DateTime] When the billing information was last changed.
      define_attribute :updated_at, DateTime

      # @!attribute updated_by
      #   @return [BillingInfoUpdatedBy]
      define_attribute :updated_by, :BillingInfoUpdatedBy

      # @!attribute valid
      #   @return [Boolean]
      define_attribute :valid, :Boolean

      # @!attribute vat_number
      #   @return [String] Customer's VAT number (to avoid having the VAT applied). This is only used for automatically collected invoices.
      define_attribute :vat_number, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AccountCreate < Request

      # @!attribute acquisition
      #   @return [AccountAcquisitionUpdatable]
      define_attribute :acquisition, :AccountAcquisitionUpdatable

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute bill_to
      #   @return [String] An enumerable describing the billing behavior of the account, specifically whether the account is self-paying or will rely on the parent account to pay.
      define_attribute :bill_to, String

      # @!attribute billing_info
      #   @return [BillingInfoCreate]
      define_attribute :billing_info, :BillingInfoCreate

      # @!attribute cc_emails
      #   @return [String] Additional email address that should receive account correspondence. These should be separated only by commas. These CC emails will receive all emails that the `email` field also receives.
      define_attribute :cc_emails, String

      # @!attribute code
      #   @return [String] The unique identifier of the account. This cannot be changed once the account is created.
      define_attribute :code, String

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute dunning_campaign_id
      #   @return [String] Unique ID to identify a dunning campaign. Available when the Dunning Campaigns feature is enabled. Used to specify if a non-default dunning campaign should be assigned to this account. For sites without multiple dunning campaigns enabled, the default dunning campaign will always be used.
      define_attribute :dunning_campaign_id, String

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer. The customer will also use this email address to log into your hosted account management pages. This value does not need to be unique.
      define_attribute :email, String

      # @!attribute exemption_certificate
      #   @return [String] The tax exemption certificate number for the account. If the merchant has an integration for the Vertex tax provider, this optional value will be sent in any tax calculation requests for the account.
      define_attribute :exemption_certificate, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute parent_account_code
      #   @return [String] The account code of the parent account to be associated with this account. Passing an empty value removes any existing parent association from this account. If both `parent_account_code` and `parent_account_id` are passed, the non-blank value in `parent_account_id` will be used. Only one level of parent child relationship is allowed. You cannot assign a parent account that itself has a parent account.
      define_attribute :parent_account_code, String

      # @!attribute parent_account_id
      #   @return [String] The UUID of the parent account to be associated with this account. Passing an empty value removes any existing parent association from this account. If both `parent_account_code` and `parent_account_id` are passed, the non-blank value in `parent_account_id` will be used. Only one level of parent child relationship is allowed. You cannot assign a parent account that itself has a parent account.
      define_attribute :parent_account_id, String

      # @!attribute preferred_locale
      #   @return [String] Used to determine the language and locale of emails sent on behalf of the merchant to the customer. The list of locales is restricted to those the merchant has enabled on the site.
      define_attribute :preferred_locale, String

      # @!attribute shipping_addresses
      #   @return [Array[ShippingAddressCreate]]
      define_attribute :shipping_addresses, Array, { :item_type => :ShippingAddressCreate }

      # @!attribute tax_exempt
      #   @return [Boolean] The tax status of the account. `true` exempts tax on the account, `false` applies tax on the account.
      define_attribute :tax_exempt, :Boolean

      # @!attribute transaction_type
      #   @return [String] An optional type designation for the payment gateway transaction created by this request. Supports 'moto' value, which is the acronym for mail order and telephone transactions.
      define_attribute :transaction_type, String

      # @!attribute username
      #   @return [String] A secondary value for the account.
      define_attribute :username, String

      # @!attribute vat_number
      #   @return [String] The VAT number of the account (to avoid having the VAT applied). This is only used for manually collected invoices.
      define_attribute :vat_number, String
    end
  end
end

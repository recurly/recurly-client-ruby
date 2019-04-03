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

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer. The customer will also use this email address to log into your hosted account management pages. This value does not need to be unique.
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute preferred_locale
      #   @return [String] Used to determine the language and locale of emails sent on behalf of the merchant to the customer. The list of locales is restricted to those the merchant has enabled on the site.
      define_attribute :preferred_locale, String, { :enum => ["da-DK", "de-CH", "de-DE", "en-AU", "en-CA", "en-GB", "en-NZ", "en-US", "es-ES", "es-MX", "es-US", "fr-CA", "fr-FR", "hi-IN", "ja-JP", "nl-BE", "nl-NL", "pt-BR", "pt-PT", "ru-RU", "tr-TR", "zh-CN"] }

      # @!attribute shipping_addresses
      #   @return [Array[ShippingAddressCreate]]
      define_attribute :shipping_addresses, Array, { :item_type => :ShippingAddressCreate }

      # @!attribute tax_exempt
      #   @return [Boolean] The tax status of the account. `true` exempts tax on the account, `false` applies tax on the account.
      define_attribute :tax_exempt, :Boolean

      # @!attribute username
      #   @return [String] A secondary value for the account.
      define_attribute :username, String

      # @!attribute vat_number
      #   @return [String] The VAT number of the account (to avoid having the VAT applied). This is only used for manually collected invoices.
      define_attribute :vat_number, String
    end
  end
end

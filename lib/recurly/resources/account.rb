# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Account < Resource

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute billing_info
      #   @return [BillingInfo]
      define_attribute :billing_info, :BillingInfo

      # @!attribute cc_emails
      #   @return [String] Additional email address that should receive account correspondence. These should be separated only by commas. These CC emails will receive all emails that the `email` field also receives.
      define_attribute :cc_emails, String

      # @!attribute [r] code
      #   @return [String] The unique identifier of the account. This cannot be changed once the account is created.
      define_attribute :code, String, { :read_only => true }

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute [r] created_at
      #   @return [DateTime] When the account was created.
      define_attribute :created_at, DateTime, { :read_only => true }

      # @!attribute [r] deleted_at
      #   @return [DateTime] If present, when the account was last marked inactive.
      define_attribute :deleted_at, DateTime, { :read_only => true }

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer. The customer will also use this email address to log into your hosted account management pages. This value does not need to be unique.
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute [r] hosted_login_token
      #   @return [String] The unique token for automatically logging the account in to the hosted management pages. You may automatically log the user into their hosted management pages by directing the user to: `https://{subdomain}.recurly.com/account/{hosted_login_token}`.
      define_attribute :hosted_login_token, String, { :read_only => true }

      # @!attribute [r] id
      #   @return [String]
      define_attribute :id, String, { :read_only => true }

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }

      # @!attribute shipping_addresses
      #   @return [Array[ShippingAddress]] The shipping addresses on the account.
      define_attribute :shipping_addresses, Array, { :item_type => :ShippingAddress }

      # @!attribute [r] state
      #   @return [String] Accounts can be either active or inactive.
      define_attribute :state, String, { :read_only => true, :enum => ["active", "inactive"] }

      # @!attribute tax_exempt
      #   @return [Boolean] The tax status of the account. `true` exempts tax on the account, `false` applies tax on the account.
      define_attribute :tax_exempt, :Boolean

      # @!attribute [r] updated_at
      #   @return [DateTime] When the account was last changed.
      define_attribute :updated_at, DateTime, { :read_only => true }

      # @!attribute username
      #   @return [String] A secondary value for the account.
      define_attribute :username, String

      # @!attribute vat_number
      #   @return [String] The VAT number of the account (to avoid having the VAT applied). This is only used for manually collected invoices.
      define_attribute :vat_number, String
    end
  end
end

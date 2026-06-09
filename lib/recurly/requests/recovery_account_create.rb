# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryAccountCreate < Request

      # @!attribute address
      #   @return [RecoveryAddress]
      define_attribute :address, :RecoveryAddress

      # @!attribute billing_infos
      #   @return [Array[RecoveryBillingInfoCreate]] If the premium Wallet feature is enabled, more than one payment method can be associated with an account, and one can be designated as a primary and one as a backup. Without the Wallet feature, only one payment method will be accepted.
      define_attribute :billing_infos, Array, { :item_type => :RecoveryBillingInfoCreate }

      # @!attribute code
      #   @return [String] The unique identifier of the account. This cannot be changed once the account is created.
      define_attribute :code, String

      # @!attribute custom_fields
      #   @return [Array[CustomField]] The custom fields will only be altered when they are included in a request. Sending an empty array will not remove any existing values. To remove a field send the name with a null or empty value.
      define_attribute :custom_fields, Array, { :item_type => :CustomField }

      # @!attribute dunning_campaign_id
      #   @return [String] Unique ID to identify a dunning campaign. Used to specify if a non-default dunning campaign should be assigned to this account. For sites without multiple dunning campaigns enabled, the default dunning campaign will always be used.
      define_attribute :dunning_campaign_id, String

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer.
      define_attribute :email, String
    end
  end
end

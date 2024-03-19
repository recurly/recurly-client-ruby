# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalSubscription < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute activated_at
      #   @return [DateTime] When the external subscription was activated in the external platform.
      define_attribute :activated_at, DateTime

      # @!attribute app_identifier
      #   @return [String] Identifier of the app that generated the external subscription.
      define_attribute :app_identifier, String

      # @!attribute auto_renew
      #   @return [Boolean] An indication of whether or not the external subscription will auto-renew at the expiration date.
      define_attribute :auto_renew, :Boolean

      # @!attribute canceled_at
      #   @return [DateTime] When the external subscription was canceled in the external platform.
      define_attribute :canceled_at, DateTime

      # @!attribute created_at
      #   @return [DateTime] When the external subscription was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute expires_at
      #   @return [DateTime] When the external subscription expires in the external platform.
      define_attribute :expires_at, DateTime

      # @!attribute external_id
      #   @return [String] The id of the subscription in the external systems., I.e. Apple App Store or Google Play Store.
      define_attribute :external_id, String

      # @!attribute external_product_reference
      #   @return [ExternalProductReferenceMini] External Product Reference details
      define_attribute :external_product_reference, :ExternalProductReferenceMini

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external subscription ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute in_grace_period
      #   @return [Boolean] An indication of whether or not the external subscription is in a grace period.
      define_attribute :in_grace_period, :Boolean

      # @!attribute last_purchased
      #   @return [DateTime] When a new billing event occurred on the external subscription in conjunction with a recent billing period, reactivation or upgrade/downgrade.
      define_attribute :last_purchased, DateTime

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute quantity
      #   @return [Integer] An indication of the quantity of a subscribed item's quantity.
      define_attribute :quantity, Integer

      # @!attribute state
      #   @return [String] External subscriptions can be active, canceled, expired, or past_due.
      define_attribute :state, String

      # @!attribute test
      #   @return [Boolean] An indication of whether or not the external subscription was purchased in a sandbox environment.
      define_attribute :test, :Boolean

      # @!attribute trial_ends_at
      #   @return [DateTime] When the external subscription trial period ends in the external platform.
      define_attribute :trial_ends_at, DateTime

      # @!attribute trial_started_at
      #   @return [DateTime] When the external subscription trial period started in the external platform.
      define_attribute :trial_started_at, DateTime

      # @!attribute updated_at
      #   @return [DateTime] When the external subscription was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

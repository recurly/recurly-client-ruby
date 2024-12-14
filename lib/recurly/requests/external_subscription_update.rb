# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalSubscriptionUpdate < Request

      # @!attribute activated_at
      #   @return [DateTime] When the external subscription was activated in the external platform.
      define_attribute :activated_at, DateTime

      # @!attribute app_identifier
      #   @return [String] Identifier of the app that generated the external subscription.
      define_attribute :app_identifier, String

      # @!attribute auto_renew
      #   @return [Boolean] An indication of whether or not the external subscription will auto-renew at the expiration date.
      define_attribute :auto_renew, :Boolean

      # @!attribute expires_at
      #   @return [DateTime] When the external subscription expires in the external platform.
      define_attribute :expires_at, DateTime

      # @!attribute external_id
      #   @return [String] Id of the subscription in the external system, i.e. Apple App Store or Google Play Store.
      define_attribute :external_id, String

      # @!attribute external_product_reference
      #   @return [ExternalProductReferenceUpdate]
      define_attribute :external_product_reference, :ExternalProductReferenceUpdate

      # @!attribute imported
      #   @return [Boolean] An indication of whether or not the external subscription was being created by a historical data import.
      define_attribute :imported, :Boolean

      # @!attribute last_purchased
      #   @return [DateTime] When a new billing event occurred on the external subscription in conjunction with a recent billing period, reactivation or upgrade/downgrade.
      define_attribute :last_purchased, DateTime

      # @!attribute quantity
      #   @return [Integer] An indication of the quantity of a subscribed item's quantity.
      define_attribute :quantity, Integer

      # @!attribute state
      #   @return [String] External subscriptions can be active, canceled, expired, past_due, voided, revoked, or paused.
      define_attribute :state, String

      # @!attribute trial_ends_at
      #   @return [DateTime] When the external subscription trial period ends in the external platform.
      define_attribute :trial_ends_at, DateTime

      # @!attribute trial_started_at
      #   @return [DateTime] When the external subscription trial period started in the external platform.
      define_attribute :trial_started_at, DateTime
    end
  end
end

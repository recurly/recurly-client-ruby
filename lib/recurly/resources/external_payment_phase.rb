# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalPaymentPhase < Resource

      # @!attribute amount
      #   @return [String] Allows up to 9 decimal places
      define_attribute :amount, String

      # @!attribute created_at
      #   @return [DateTime] When the external subscription was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute ending_billing_period_index
      #   @return [Integer] Ending Billing Period Index
      define_attribute :ending_billing_period_index, Integer

      # @!attribute ends_at
      #   @return [DateTime] Ends At
      define_attribute :ends_at, DateTime

      # @!attribute external_subscription
      #   @return [ExternalSubscription] Subscription from an external resource such as Apple App Store or Google Play Store.
      define_attribute :external_subscription, :ExternalSubscription

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external payment phase ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute offer_name
      #   @return [String] Name of the discount offer given, e.g. "introductory"
      define_attribute :offer_name, String

      # @!attribute offer_type
      #   @return [String] Type of discount offer given, e.g. "FREE_TRIAL"
      define_attribute :offer_type, String

      # @!attribute period_count
      #   @return [Integer] Number of billing periods
      define_attribute :period_count, Integer

      # @!attribute period_length
      #   @return [String] Billing cycle length
      define_attribute :period_length, String

      # @!attribute started_at
      #   @return [DateTime] Started At
      define_attribute :started_at, DateTime

      # @!attribute starting_billing_period_index
      #   @return [Integer] Starting Billing Period Index
      define_attribute :starting_billing_period_index, Integer

      # @!attribute updated_at
      #   @return [DateTime] When the external subscription was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

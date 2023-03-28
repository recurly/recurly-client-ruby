# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExternalInvoice < Resource

      # @!attribute account
      #   @return [AccountMini] Account mini details
      define_attribute :account, :AccountMini

      # @!attribute created_at
      #   @return [DateTime] When the external invoice was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute external_id
      #   @return [String] An identifier which associates the external invoice to a corresponding object in an external platform.
      define_attribute :external_id, String

      # @!attribute external_subscription
      #   @return [ExternalSubscription] Subscription from an external resource such as Apple App Store or Google Play Store.
      define_attribute :external_subscription, :ExternalSubscription

      # @!attribute id
      #   @return [String] System-generated unique identifier for an external invoice ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute line_items
      #   @return [Array[ExternalCharge]]
      define_attribute :line_items, Array, { :item_type => :ExternalCharge }

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute purchased_at
      #   @return [DateTime] When the invoice was created in the external platform.
      define_attribute :purchased_at, DateTime

      # @!attribute state
      #   @return [String]
      define_attribute :state, String

      # @!attribute total
      #   @return [Float] Total
      define_attribute :total, Float

      # @!attribute updated_at
      #   @return [DateTime] When the external invoice was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

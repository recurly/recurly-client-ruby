# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class SubscriptionAddOn < Resource

      # @!attribute add_on
      #   @return [AddOnMini]
      define_attribute :add_on, :AddOnMini

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute expired_at
      #   @return [DateTime] Expired at
      define_attribute :expired_at, DateTime

      # @!attribute id
      #   @return [String] Subscription Add-on ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute quantity
      #   @return [Integer] Add-on quantity
      define_attribute :quantity, Integer

      # @!attribute subscription_id
      #   @return [String] Subscription ID
      define_attribute :subscription_id, String

      # @!attribute unit_amount
      #   @return [Float] This is priced in the subscription's currency.
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime
    end
  end
end

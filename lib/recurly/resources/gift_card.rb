# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class GiftCard < Resource

      # @!attribute balance
      #   @return [Float] The remaining credit on the recipient account associated with this gift card. Only has a value once the gift card has been redeemed. Can be used to create gift card balance displays for your customers.
      define_attribute :balance, Float

      # @!attribute canceled_at
      #   @return [DateTime] When the gift card was canceled.
      define_attribute :canceled_at, DateTime

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute delivered_at
      #   @return [DateTime] When the gift card was sent to the recipient by Recurly via email, if method was email and the "Gift Card Delivery" email template was enabled. This will be empty for post delivery or email delivery where the email template was disabled.
      define_attribute :delivered_at, DateTime

      # @!attribute delivery
      #   @return [GiftCardDelivery] The delivery details for the gift card.
      define_attribute :delivery, :GiftCardDelivery

      # @!attribute gifter_account_id
      #   @return [String] The ID of the account that purchased the gift card.
      define_attribute :gifter_account_id, String

      # @!attribute id
      #   @return [String] Gift card ID
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute product_code
      #   @return [String] The product code or SKU of the gift card product.
      define_attribute :product_code, String

      # @!attribute purchase_invoice_id
      #   @return [String] The ID of the invoice for the gift card purchase made by the gifter.
      define_attribute :purchase_invoice_id, String

      # @!attribute recipient_account_id
      #   @return [String] The ID of the account that redeemed the gift card redemption code.  Does not have a value until gift card is redeemed.
      define_attribute :recipient_account_id, String

      # @!attribute redeemed_at
      #   @return [DateTime] When the gift card was redeemed by the recipient.
      define_attribute :redeemed_at, DateTime

      # @!attribute redemption_code
      #   @return [String] The unique redemption code for the gift card, generated by Recurly. Will be 16 characters, alphanumeric, displayed uppercase, but accepted in any case at redemption. Used by the recipient account to create a credit in the amount of the `unit_amount` on their account.
      define_attribute :redemption_code, String

      # @!attribute redemption_invoice_id
      #   @return [String] The ID of the invoice for the gift card redemption made by the recipient.  Does not have a value until gift card is redeemed.
      define_attribute :redemption_invoice_id, String

      # @!attribute unit_amount
      #   @return [Float] The amount of the gift card, which is the amount of the charge to the gifter account and the amount of credit that is applied to the recipient account upon successful redemption.
      define_attribute :unit_amount, Float

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

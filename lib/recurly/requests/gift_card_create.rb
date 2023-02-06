# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class GiftCardCreate < Request

      # @!attribute currency
      #   @return [String] 3-letter ISO 4217 currency code.
      define_attribute :currency, String

      # @!attribute delivery
      #   @return [GiftCardDeliveryCreate] The delivery details for the gift card.
      define_attribute :delivery, :GiftCardDeliveryCreate

      # @!attribute gifter_account
      #   @return [AccountPurchase] Block of account details for the gifter. This references an existing account_code.
      define_attribute :gifter_account, :AccountPurchase

      # @!attribute product_code
      #   @return [String] The product code or SKU of the gift card product.
      define_attribute :product_code, String

      # @!attribute unit_amount
      #   @return [Float] The amount of the gift card, which is the amount of the charge to the gifter account and the amount of credit that is applied to the recipient account upon successful redemption.
      define_attribute :unit_amount, Float
    end
  end
end

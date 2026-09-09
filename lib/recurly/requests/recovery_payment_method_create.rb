# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class RecoveryPaymentMethodCreate < Request

      # @!attribute card_type
      #   @return [String] The card brand (e.g. `Visa`, `MasterCard`). Present for `credit_card`, `apple_pay`, and `google_pay`/`google_pay_device_pan`; omitted for `paypal_billing_agreement`.
      define_attribute :card_type, String

      # @!attribute exp_month
      #   @return [Integer] Expiration month.
      define_attribute :exp_month, Integer

      # @!attribute exp_year
      #   @return [Integer] Expiration year.
      define_attribute :exp_year, Integer

      # @!attribute first_six
      #   @return [String] For a plain card, the card's own first six digits (BIN).  For a tokenized wallet payment (`apple_pay`, `google_pay`, or `google_pay_device_pan`), this is the DPAN's (the wallet/device token's own number) first six digits — **not** the underlying card's (FPAN). The FPAN is never accepted or represented; no separate wallet-specific field is provided.
      define_attribute :first_six, String

      # @!attribute last_four
      #   @return [String] The card's (or, for a tokenized wallet payment, the DPAN's) last four digits. See `first_six` for the DPAN-vs-FPAN distinction on wallets.
      define_attribute :last_four, String

      # @!attribute object
      #   @return [String] The payment method type.
      define_attribute :object, String
    end
  end
end

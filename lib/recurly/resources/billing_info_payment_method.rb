# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class BillingInfoPaymentMethod < Resource

      # @!attribute card_type
      #   @return [String] Visa, MasterCard, American Express, Discover, JCB, etc.
      define_attribute :card_type, String, { :enum => ["American Express", "Dankort", "Diners Club", "Discover", "Forbrugsforeningen", "JCB", "Laser", "Maestro", "MasterCard", "Test Card", "Unknown", "Visa"] }

      # @!attribute exp_month
      #   @return [Integer] Expiration month.
      define_attribute :exp_month, Integer

      # @!attribute exp_year
      #   @return [Integer] Expiration year.
      define_attribute :exp_year, Integer

      # @!attribute first_six
      #   @return [String] Credit card number's first six digits.
      define_attribute :first_six, String

      # @!attribute last_four
      #   @return [String] Credit card number's last four digits.
      define_attribute :last_four, String

      # @!attribute object
      #   @return [String]
      define_attribute :object, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class TransactionFraudInfo < Resource

      # @!attribute decision
      #   @return [String] Kount decision
      define_attribute :decision, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute reference
      #   @return [String] Kount transaction reference ID
      define_attribute :reference, String

      # @!attribute risk_rules_triggered
      #   @return [Array[FraudRiskRule]] A list of fraud risk rules that were triggered for the transaction.
      define_attribute :risk_rules_triggered, Array, { :item_type => :FraudRiskRule }

      # @!attribute score
      #   @return [Integer] Kount score
      define_attribute :score, Integer
    end
  end
end

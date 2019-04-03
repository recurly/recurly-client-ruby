# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class FraudInfo < Resource

      # @!attribute decision
      #   @return [String] Kount decision
      define_attribute :decision, String, { :enum => ["approve", "review", "decline", "escalate"] }

      # @!attribute risk_rules_triggered
      #   @return [Hash] Kount rules
      define_attribute :risk_rules_triggered, Hash

      # @!attribute score
      #   @return [Integer] Kount score
      define_attribute :score, Integer
    end
  end
end

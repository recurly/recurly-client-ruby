# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PercentageTier < Resource

      # @!attribute ending_amount
      #   @return [Float] Ending amount for the tier. Allows up to 2 decimal places. The last tier ending_amount is null.
      define_attribute :ending_amount, Float

      # @!attribute usage_percentage
      #   @return [String] Decimal usage percentage.
      define_attribute :usage_percentage, String
    end
  end
end

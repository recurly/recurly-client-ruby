# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PercentageTier < Request

      # @!attribute ending_amount
      #   @return [Float] Ending amount for the tier. Allows up to 2 decimal places. Must be left empty if it is the final tier.
      define_attribute :ending_amount, Float

      # @!attribute usage_percentage
      #   @return [String] The percentage taken of the monetary amount of usage tracked. This can be up to 4 decimal places represented as a string.
      define_attribute :usage_percentage, String
    end
  end
end

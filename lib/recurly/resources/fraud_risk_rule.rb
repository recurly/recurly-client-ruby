# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class FraudRiskRule < Resource

      # @!attribute code
      #   @return [String] The Kount rule number.
      define_attribute :code, String

      # @!attribute message
      #   @return [String] Description of why the rule was triggered
      define_attribute :message, String
    end
  end
end

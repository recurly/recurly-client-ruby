# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PriceSegment < Resource

      # @!attribute code
      #   @return [String] The price segment code, e.g. `my-price-segment`.
      define_attribute :code, String

      # @!attribute id
      #   @return [String] The price segment ID, e.g. `e28zov4fw0v2`.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
    end
  end
end

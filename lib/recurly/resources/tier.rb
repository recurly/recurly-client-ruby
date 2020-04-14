# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Tier < Resource

      # @!attribute currencies
      #   @return [Array[Pricing]] Tier pricing
      define_attribute :currencies, Array, { :item_type => :Pricing }

      # @!attribute ending_quantity
      #   @return [Integer] Ending quantity
      define_attribute :ending_quantity, Integer
    end
  end
end

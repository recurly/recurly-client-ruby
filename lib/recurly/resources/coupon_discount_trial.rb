# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CouponDiscountTrial < Resource

      # @!attribute length
      #   @return [Integer] Trial length measured in the units specified by the sibling `unit` property
      define_attribute :length, Integer

      # @!attribute unit
      #   @return [String] Temporal unit of the free trial
      define_attribute :unit, String, { :enum => ["day", "week", "month"] }
    end
  end
end

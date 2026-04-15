# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class UniqueCouponCodeGenerationResponse < Resource

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute unique_coupon_codes
      #   @return [Array[UniqueCouponCode]] An array containing the newly generated unique coupon codes.
      define_attribute :unique_coupon_codes, Array, { :item_type => :UniqueCouponCode }
    end
  end
end

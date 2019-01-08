# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class CouponBulkCreate < Request

      # @!attribute number_of_unique_codes
      #   @return [Integer] The quantity of unique coupon codes to generate
      define_attribute :number_of_unique_codes, Integer
    end
  end
end

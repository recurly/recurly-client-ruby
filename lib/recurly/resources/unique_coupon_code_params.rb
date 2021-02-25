# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class UniqueCouponCodeParams < Resource

      # @!attribute begin_time
      #   @return [DateTime] The date-time to be included when listing UniqueCouponCodes
      define_attribute :begin_time, DateTime

      # @!attribute limit
      #   @return [Integer] The number of UniqueCouponCodes that will be generated
      define_attribute :limit, Integer

      # @!attribute order
      #   @return [String] Sort order to list newly generated UniqueCouponCodes (should always be `asc`)
      define_attribute :order, String

      # @!attribute sort
      #   @return [String] Sort field to list newly generated UniqueCouponCodes (should always be `created_at`)
      define_attribute :sort, String
    end
  end
end

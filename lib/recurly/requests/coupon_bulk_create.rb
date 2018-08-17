module Recurly
  module Requests
    class CouponBulkCreate < Request

      # @!attribute number_of_unique_codes
      #   @return [Integer] The quantity of unique coupon codes to generate
      define_attribute :number_of_unique_codes, Integer
    end
  end
end

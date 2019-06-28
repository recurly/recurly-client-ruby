# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionShippingPurchase < Request

      # @!attribute amount
      #   @return [Float] Assigns the subscription's shipping cost. If this is greater than zero then a `method_id` or `method_code` is required.
      define_attribute :amount, Float

      # @!attribute method_code
      #   @return [String] The code of the shipping method used to deliver the subscription. If `method_id` and `method_code` are both present, `method_id` will be used.
      define_attribute :method_code, String

      # @!attribute method_id
      #   @return [String] The id of the shipping method used to deliver the subscription. If `method_id` and `method_code` are both present, `method_id` will be used.
      define_attribute :method_id, String
    end
  end
end

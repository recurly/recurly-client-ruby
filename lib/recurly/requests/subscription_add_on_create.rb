# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionAddOnCreate < Request

      # @!attribute code
      #   @return [String] Add-on code
      define_attribute :code, String

      # @!attribute quantity
      #   @return [Integer] Optionally override the default quantity.
      define_attribute :quantity, Integer

      # @!attribute unit_amount
      #   @return [Float] Override the default unit amount of the add-on by setting this value.
      define_attribute :unit_amount, Float
    end
  end
end

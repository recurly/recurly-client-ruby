# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class SubscriptionAddOnUpdate < Request

      # @!attribute code
      #   @return [String] Add-on code
      define_attribute :code, String

      # @!attribute id
      #   @return [String] Set this to include or modify an existing subscription add-on.
      define_attribute :id, String

      # @!attribute quantity
      #   @return [Integer] Quantity
      define_attribute :quantity, Integer

      # @!attribute unit_amount
      #   @return [Float] Optionally, override the add-on's default unit amount.
      define_attribute :unit_amount, Float
    end
  end
end

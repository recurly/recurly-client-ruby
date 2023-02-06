# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class GiftCardRedeem < Request

      # @!attribute recipient_account
      #   @return [AccountReference] The account for the recipient of the gift card.
      define_attribute :recipient_account, :AccountReference
    end
  end
end

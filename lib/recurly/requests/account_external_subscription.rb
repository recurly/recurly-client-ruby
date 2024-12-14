# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AccountExternalSubscription < Request

      # @!attribute account_code
      #   @return [String] The account code of a new or existing account to be used when creating the external subscription.
      define_attribute :account_code, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalAccountCreate < Request

      # @!attribute external_account_code
      #   @return [String] Represents the account code for the external account.
      define_attribute :external_account_code, String

      # @!attribute external_connection_type
      #   @return [String] Represents the connection type. `AppleAppStore` or `GooglePlayStore`
      define_attribute :external_connection_type, String
    end
  end
end

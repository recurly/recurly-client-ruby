# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalAccount < Request

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute external_account_code
      #   @return [String] Represents the account code for the external account.
      define_attribute :external_account_code, String

      # @!attribute external_connection_type
      #   @return [String] Represents the connection type. `AppleAppStore` or `GooglePlayStore`
      define_attribute :external_connection_type, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

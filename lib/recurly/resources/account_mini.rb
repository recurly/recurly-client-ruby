# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountMini < Resource

      # @!attribute code
      #   @return [String] The unique identifier of the account.
      define_attribute :code, String

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer.
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute id
      #   @return [String]
      define_attribute :id, String

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
    end
  end
end

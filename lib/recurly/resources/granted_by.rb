# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class GrantedBy < Resource

      # @!attribute id
      #   @return [String] The ID of the subscription or external subscription that grants the permission to the account.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object Type
      define_attribute :object, String
    end
  end
end

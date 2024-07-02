# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class GeneralLedgerAccountCreate < Request

      # @!attribute account_type
      #   @return [String]
      define_attribute :account_type, String

      # @!attribute code
      #   @return [String] Unique code to identify the ledger account. Each code must start with a letter or number. The following special characters are allowed: `-_.,:`
      define_attribute :code, String

      # @!attribute description
      #   @return [String] Optional description.
      define_attribute :description, String
    end
  end
end

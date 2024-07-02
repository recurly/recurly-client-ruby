# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class GeneralLedgerAccount < Resource

      # @!attribute account_type
      #   @return [String]
      define_attribute :account_type, String

      # @!attribute code
      #   @return [String] Unique code to identify the ledger account. Each code must start with a letter or number. The following special characters are allowed: `-_.,:`
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute description
      #   @return [String] Optional description.
      define_attribute :description, String

      # @!attribute id
      #   @return [String] The ID of a general ledger account. General ledger accounts are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :id, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

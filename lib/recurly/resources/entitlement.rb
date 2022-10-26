# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Entitlement < Resource

      # @!attribute created_at
      #   @return [DateTime] Time object was created.
      define_attribute :created_at, DateTime

      # @!attribute customer_permission
      #   @return [CustomerPermission]
      define_attribute :customer_permission, :CustomerPermission

      # @!attribute granted_by
      #   @return [Array[GrantedBy]] Subscription or item that granted the customer permission.
      define_attribute :granted_by, Array, { :item_type => :GrantedBy }

      # @!attribute object
      #   @return [String] Entitlement
      define_attribute :object, String

      # @!attribute updated_at
      #   @return [DateTime] Time the object was last updated
      define_attribute :updated_at, DateTime
    end
  end
end

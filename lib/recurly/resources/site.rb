# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Site < Resource

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime

      # @!attribute features
      #   @return [Array[String]] A list of features enabled for the site.
      define_attribute :features, Array, { :item_type => String }

      # @!attribute id
      #   @return [String] Site ID
      define_attribute :id, String

      # @!attribute mode
      #   @return [String] Mode
      define_attribute :mode, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute settings
      #   @return [Settings]
      define_attribute :settings, :Settings

      # @!attribute subdomain
      #   @return [String]
      define_attribute :subdomain, String

      # @!attribute updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime
    end
  end
end

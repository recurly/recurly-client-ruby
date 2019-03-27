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

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, { :read_only => true }

      # @!attribute [r] deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime, { :read_only => true }

      # @!attribute features
      #   @return [Array[String]] A list of features enabled for the site.
      define_attribute :features, Array, { :item_type => String }

      # @!attribute [r] id
      #   @return [String] Site ID
      define_attribute :id, String, { :read_only => true }

      # @!attribute [r] mode
      #   @return [String] Mode
      define_attribute :mode, String, { :read_only => true, :enum => ["development", "production", "sandbox"] }

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }

      # @!attribute [r] public_api_key
      #   @return [String] This value is used to configure RecurlyJS to submit tokenized billing information.
      define_attribute :public_api_key, String, { :read_only => true }

      # @!attribute settings
      #   @return [Settings]
      define_attribute :settings, :Settings

      # @!attribute [r] subdomain
      #   @return [String]
      define_attribute :subdomain, String, { :read_only => true }

      # @!attribute [r] updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime, { :read_only => true }
    end
  end
end

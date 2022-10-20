# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class MeasuredUnit < Resource
      
      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime
      
      # @!attribute deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime
      
      # @!attribute description
      #   @return [String] Optional internal description.
      define_attribute :description, String
      
      # @!attribute display_name
      #   @return [String] Display name for the measured unit. Can only contain spaces, underscores and must be alphanumeric.
      define_attribute :display_name, String
      
      # @!attribute id
      #   @return [String] Item ID
      define_attribute :id, String
      
      # @!attribute name
      #   @return [String] Unique internal name of the measured unit on your site.
      define_attribute :name, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
      # @!attribute state
      #   @return [String] The current state of the measured unit.
      define_attribute :state, String
      
      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
      
    end
  end
end

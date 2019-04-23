# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class User < Resource

      # @!attribute created_at
      #   @return [DateTime]
      define_attribute :created_at, DateTime

      # @!attribute deleted_at
      #   @return [DateTime]
      define_attribute :deleted_at, DateTime

      # @!attribute email
      #   @return [String]
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

      # @!attribute time_zone
      #   @return [String]
      define_attribute :time_zone, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PerformanceObligation < Resource

      # @!attribute created_at
      #   @return [DateTime] Created At
      define_attribute :created_at, DateTime

      # @!attribute id
      #   @return [String] The ID of a performance obligation. Performance obligations are only accessible as a part of the Recurly RevRec Standard and Recurly RevRec Advanced features.
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Performance Obligation Name
      define_attribute :name, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end

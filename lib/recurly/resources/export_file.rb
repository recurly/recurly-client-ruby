# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExportFile < Resource
      
      # @!attribute href
      #   @return [String] A presigned link to download the export file.
      define_attribute :href, String
      
      # @!attribute md5sum
      #   @return [String] MD5 hash of the export file.
      define_attribute :md5sum, String
      
      # @!attribute name
      #   @return [String] Name of the export file.
      define_attribute :name, String
      
    end
  end
end

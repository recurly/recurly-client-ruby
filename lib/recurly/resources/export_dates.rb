# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ExportDates < Resource

      # @!attribute dates
      #   @return [Array[String]] An array of dates that have available exports.
      define_attribute :dates, Array, { :item_type => String }
    end
  end
end

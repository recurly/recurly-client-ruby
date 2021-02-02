# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class MeasuredUnitUpdate < Request

      # @!attribute description
      #   @return [String] Optional internal description.
      define_attribute :description, String

      # @!attribute display_name
      #   @return [String] Display name for the measured unit.
      define_attribute :display_name, String

      # @!attribute name
      #   @return [String] Unique internal name of the measured unit on your site.
      define_attribute :name, String
    end
  end
end

# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class ExternalProductUpdate < Request

      # @!attribute plan_id
      #   @return [String] Recurly plan UUID.
      define_attribute :plan_id, String
    end
  end
end

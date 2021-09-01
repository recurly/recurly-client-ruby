# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class DunningCampaignsBulkUpdateResponse < Resource

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute plans
      #   @return [Array[Plan]] An array containing all of the `Plan` resources that have been updated.
      define_attribute :plans, Array, { :item_type => :Plan }
    end
  end
end

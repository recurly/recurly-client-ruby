# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningCampaignsBulkUpdate < Request
      
      # @!attribute plan_codes
      #   @return [Array[String]] List of `plan_codes` associated with the Plans for which the dunning campaign should be updated. Required unless `plan_ids` is present.
      define_attribute :plan_codes, Array, {:item_type=>String}
      
      # @!attribute plan_ids
      #   @return [Array[String]] List of `plan_ids` associated with the Plans for which the dunning campaign should be updated. Required unless `plan_codes` is present.
      define_attribute :plan_ids, Array, {:item_type=>String}
      
    end
  end
end

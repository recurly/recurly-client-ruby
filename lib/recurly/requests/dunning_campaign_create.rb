# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningCampaignCreate < Request

      # @!attribute code
      #   @return [String] Campaign code.
      define_attribute :code, String

      # @!attribute description
      #   @return [String] Campaign description.
      define_attribute :description, String

      # @!attribute dunning_cycles
      #   @return [Array[DunningCycleWrite]] Dunning Cycle settings. One entry per collection method (`automatic`, `manual`, `trial`); each type may appear at most once.
      define_attribute :dunning_cycles, Array, { :item_type => :DunningCycleWrite }

      # @!attribute name
      #   @return [String] Campaign name.
      define_attribute :name, String
    end
  end
end

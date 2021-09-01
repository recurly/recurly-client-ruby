# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class DunningCampaign < Resource

      # @!attribute code
      #   @return [String] Campaign code.
      define_attribute :code, String

      # @!attribute created_at
      #   @return [DateTime] When the current campaign was created in Recurly.
      define_attribute :created_at, DateTime

      # @!attribute default_campaign
      #   @return [Boolean] Whether or not this is the default campaign for accounts or plans without an assigned dunning campaign.
      define_attribute :default_campaign, :Boolean

      # @!attribute deleted_at
      #   @return [DateTime] When the current campaign was deleted in Recurly.
      define_attribute :deleted_at, DateTime

      # @!attribute description
      #   @return [String] Campaign description.
      define_attribute :description, String

      # @!attribute dunning_cycles
      #   @return [Array[DunningCycle]] Dunning Cycle settings.
      define_attribute :dunning_cycles, Array, { :item_type => :DunningCycle }

      # @!attribute id
      #   @return [String]
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Campaign name.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute updated_at
      #   @return [DateTime] When the current campaign was updated in Recurly.
      define_attribute :updated_at, DateTime
    end
  end
end

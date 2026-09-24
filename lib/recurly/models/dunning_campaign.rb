# frozen_string_literal: true

module Recurly
  # Represents a DunningCampaign in Recurly
  class DunningCampaign < Recurly::Model
    def self.list(params:)
      client.list_dunning_campaigns(params: params)
    end

    def self.get(id:)
      client.get_dunning_campaign(dunning_campaign_id: id)
    end
  end
end

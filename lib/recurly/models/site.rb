# frozen_string_literal: true

module Recurly
  # Represents a Site in Recurly
  class Site < Recurly::Model
    def self.list(params:)
      client.list_sites(params: params)
    end

    def self.get(id:)
      client.get_site(site_id: id)
    end
  end
end

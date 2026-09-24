# frozen_string_literal: true

module Recurly
  # Represents a ExternalSubscription in Recurly
  class ExternalSubscription < Recurly::Model
    def self.list(params:)
      client.list_external_subscriptions(params: params)
    end

    def self.get(id:)
      client.get_external_subscription(external_subscription_id: id)
    end
  end
end

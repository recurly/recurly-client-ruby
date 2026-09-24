# frozen_string_literal: true

module Recurly
  # Represents a Subscription in Recurly
  class Subscription < Recurly::Model
    def self.api_keys
      API_KEYS + %i[account_id]
    end

    def self.list(params:)
      return client.list_account_subscriptions(account_id: params[:account_id]) if params.key?(:account_id)

      client.list_subscriptions(params: params)
    end

    def self.get(id:)
      client.get_subscription(subscription_id: id)
    end
  end
end

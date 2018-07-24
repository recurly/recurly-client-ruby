module Recurly
  module Resources
    class AccountAcquisition < Resource

      # @!attribute account
      #   @return [Account]
      define_attribute :account, :Account

      # @!attribute campaign
      #   @return [String] An arbitrary identifier for the marketing campaign that led to the acquisition of this account.
      define_attribute :campaign, String

      # @!attribute channel
      #   @return [String] The channel through which the account was acquired.
      define_attribute :channel, String, {:enum => ["referral", "social_media", "email", "paid_search", "organic_search", "direct_traffic", "marketing_content", "blog", "events", "outbound_sales", "advertising", "public_relations", "other"]}

      # @!attribute cost
      #   @return [Hash] Account balance
      define_attribute :cost, Hash

      # @!attribute [r] created_at
      #   @return [DateTime] When the account acquisition data was created.
      define_attribute :created_at, DateTime, {:read_only => true}

      # @!attribute [r] id
      #   @return [String]
      define_attribute :id, String, {:read_only => true}

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only => true}

      # @!attribute subchannel
      #   @return [String] An arbitrary subchannel string representing a distinction/subcategory within a broader channel.
      define_attribute :subchannel, String

      # @!attribute [r] updated_at
      #   @return [DateTime] When the account acquisition data was last changed.
      define_attribute :updated_at, DateTime, {:read_only => true}
    end
  end
end

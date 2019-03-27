# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class AccountAcquisitionUpdatable < Request

      # @!attribute campaign
      #   @return [String] An arbitrary identifier for the marketing campaign that led to the acquisition of this account.
      define_attribute :campaign, String

      # @!attribute channel
      #   @return [String] The channel through which the account was acquired.
      define_attribute :channel, String, { :enum => ["referral", "social_media", "email", "paid_search", "organic_search", "direct_traffic", "marketing_content", "blog", "events", "outbound_sales", "advertising", "public_relations", "other"] }

      # @!attribute cost
      #   @return [Hash] Account balance
      define_attribute :cost, Hash

      # @!attribute subchannel
      #   @return [String] An arbitrary subchannel string representing a distinction/subcategory within a broader channel.
      define_attribute :subchannel, String
    end
  end
end

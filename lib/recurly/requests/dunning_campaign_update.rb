# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningCampaignUpdate < Request

      # @!attribute retry_settings
      #   @return [DunningRetrySettings] Retry phase configuration for a dunning campaign's automatic collection cycle. Partial updates are supported — only the keys provided are changed; all other retry settings are inherited from the prior version.
      define_attribute :retry_settings, :DunningRetrySettings
    end
  end
end

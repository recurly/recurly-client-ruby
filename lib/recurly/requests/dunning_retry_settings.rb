# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningRetrySettings < Request

      # @!attribute double_tap
      #   @return [Boolean] Whether to enable double-tap retries at the start of the window. Absence or null means off.
      define_attribute :double_tap, :Boolean

      # @!attribute front_load_days
      #   @return [Integer] Number of days to front-load retries at the beginning of the window. Absence, null, or 0 means off.
      define_attribute :front_load_days, Integer

      # @!attribute max_attempts
      #   @return [Integer] Total number of retry attempts across the dunning window. Defaults to 20.
      define_attribute :max_attempts, Integer

      # @!attribute max_retries
      #   @return [Integer] Maximum number of decline retries before the invoice is failed. Defaults to 10.
      define_attribute :max_retries, Integer
    end
  end
end

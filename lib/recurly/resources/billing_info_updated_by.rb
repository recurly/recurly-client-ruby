# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class BillingInfoUpdatedBy < Resource

      # @!attribute country
      #   @return [String] Country, 2-letter ISO 3166-1 alpha-2 code matching the origin IP address, if known by Recurly.
      define_attribute :country, String

      # @!attribute ip
      #   @return [String] Customer's IP address when updating their billing information.
      define_attribute :ip, String
    end
  end
end

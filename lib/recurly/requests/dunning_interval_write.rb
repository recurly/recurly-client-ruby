# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class DunningIntervalWrite < Request

      # @!attribute days
      #   @return [Integer] Number of days before sending the next email.
      define_attribute :days, Integer

      # @!attribute email_template_id
      #   @return [String] The id of the custom email template to assign to this interval, from `GET /dunning_campaigns/email_templates`. `null` uses the system default template for this interval.
      define_attribute :email_template_id, String
    end
  end
end

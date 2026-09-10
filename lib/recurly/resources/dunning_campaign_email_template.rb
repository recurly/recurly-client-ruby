# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class DunningCampaignEmailTemplate < Resource

      # @!attribute id
      #   @return [String] The id to assign under `intervals[].email_template_id`.
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Template name.
      define_attribute :name, String

      # @!attribute type
      #   @return [String] The root template this custom template replaces, e.g. `payment_declined`, `invoice_past_due`, `post_trial_payment_declined`, `subscription_canceled_nonpayment`.
      define_attribute :type, String
    end
  end
end

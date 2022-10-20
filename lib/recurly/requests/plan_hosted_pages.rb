# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class PlanHostedPages < Request
      
      # @!attribute bypass_confirmation
      #   @return [Boolean] If `true`, the customer will be sent directly to your `success_url` after a successful signup, bypassing Recurly's hosted confirmation page.
      define_attribute :bypass_confirmation, :Boolean
      
      # @!attribute cancel_url
      #   @return [String] URL to redirect to on canceled signup on the hosted payment pages.
      define_attribute :cancel_url, String
      
      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the plan.
      define_attribute :display_quantity, :Boolean
      
      # @!attribute success_url
      #   @return [String] URL to redirect to after signup on the hosted payment pages.
      define_attribute :success_url, String
      
    end
  end
end

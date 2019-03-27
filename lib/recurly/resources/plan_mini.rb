# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class PlanMini < Resource

      # @!attribute code
      #   @return [String] Unique code to identify the plan. This is used in Hosted Payment Page URLs and in the invoice exports.
      define_attribute :code, String

      # @!attribute [r] id
      #   @return [String] Plan ID
      define_attribute :id, String, { :read_only => true }

      # @!attribute name
      #   @return [String] This name describes your plan and will appear on the Hosted Payment Page and the subscriber's invoice.
      define_attribute :name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }
    end
  end
end

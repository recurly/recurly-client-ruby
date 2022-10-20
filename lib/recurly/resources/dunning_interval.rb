# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class DunningInterval < Resource
      
      # @!attribute days
      #   @return [Integer] Number of days before sending the next email.
      define_attribute :days, Integer
      
      # @!attribute email_template
      #   @return [String] Email template being used.
      define_attribute :email_template, String
      
    end
  end
end

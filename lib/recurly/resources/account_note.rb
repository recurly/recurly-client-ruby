# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountNote < Resource
      
      # @!attribute account_id
      #   @return [String] 
      define_attribute :account_id, String
      
      # @!attribute created_at
      #   @return [DateTime] 
      define_attribute :created_at, DateTime
      
      # @!attribute id
      #   @return [String] 
      define_attribute :id, String
      
      # @!attribute message
      #   @return [String] 
      define_attribute :message, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
      # @!attribute user
      #   @return [User] 
      define_attribute :user, :User
      
    end
  end
end

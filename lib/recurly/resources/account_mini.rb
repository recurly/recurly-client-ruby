# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountMini < Resource
      
      # @!attribute bill_to
      #   @return [String] 
      define_attribute :bill_to, String
      
      # @!attribute code
      #   @return [String] The unique identifier of the account.
      define_attribute :code, String
      
      # @!attribute company
      #   @return [String] 
      define_attribute :company, String
      
      # @!attribute dunning_campaign_id
      #   @return [String] Unique ID to identify a dunning campaign. Used to specify if a non-default dunning campaign should be assigned to this account. For sites without multiple dunning campaigns enabled, the default dunning campaign will always be used.
      define_attribute :dunning_campaign_id, String
      
      # @!attribute email
      #   @return [String] The email address used for communicating with this customer.
      define_attribute :email, String
      
      # @!attribute first_name
      #   @return [String] 
      define_attribute :first_name, String
      
      # @!attribute id
      #   @return [String] 
      define_attribute :id, String
      
      # @!attribute last_name
      #   @return [String] 
      define_attribute :last_name, String
      
      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String
      
      # @!attribute parent_account_id
      #   @return [String] 
      define_attribute :parent_account_id, String
      
    end
  end
end

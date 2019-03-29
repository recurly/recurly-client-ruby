# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class AccountBalance < Resource

      # @!attribute account
      #   @return [AccountMini]
      define_attribute :account, :AccountMini

      # @!attribute balances
      #   @return [Array[AccountBalanceAmount]]
      define_attribute :balances, Array, { :item_type => :AccountBalanceAmount }

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }

      # @!attribute past_due
      #   @return [Boolean]
      define_attribute :past_due, :Boolean
    end
  end
end

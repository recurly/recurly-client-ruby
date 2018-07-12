module Recurly
  module Resources
    class AccountBalance < Resource

      # @!attribute account
      #   @return [AccountMini]
      define_attribute :account, :AccountMini

      # @!attribute balances
      #   @return [Hash] Account balance
      define_attribute :balances, Hash

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only=>true}

      # @!attribute past_due
      #   @return [Boolean]
      define_attribute :past_due, :Boolean

    end
  end
end

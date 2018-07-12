module Recurly
  module Resources
    class AccountNote < Resource

      # @!attribute account_id
      #   @return [String]
      define_attribute :account_id, String

      # @!attribute [r] created_at
      #   @return [DateTime]
      define_attribute :created_at, DateTime, {:read_only=>true}

      # @!attribute [r] id
      #   @return [String]
      define_attribute :id, String, {:read_only=>true}

      # @!attribute message
      #   @return [String]
      define_attribute :message, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only=>true}

      # @!attribute user
      #   @return [User]
      define_attribute :user, :User

    end
  end
end

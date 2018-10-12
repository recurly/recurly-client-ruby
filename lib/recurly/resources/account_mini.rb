module Recurly
  module Resources
    class AccountMini < Resource

      # @!attribute code
      #   @return [String] The unique identifier of the account.
      define_attribute :code, String

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute email
      #   @return [String] The email address used for communicating with this customer.
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute [r] id
      #   @return [String]
      define_attribute :id, String, {:read_only => true}

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only => true}
    end
  end
end

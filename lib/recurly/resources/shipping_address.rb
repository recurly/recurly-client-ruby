module Recurly
  module Resources
    class ShippingAddress < Resource

      # @!attribute [r] account_id
      #   @return [String] Account ID
      define_attribute :account_id, String, {:read_only=>true}

      # @!attribute city
      #   @return [String]
      define_attribute :city, String

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO code.
      define_attribute :country, String

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, {:read_only=>true}

      # @!attribute email
      #   @return [String]
      define_attribute :email, String

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute [r] id
      #   @return [String] Shipping Address ID
      define_attribute :id, String, {:read_only=>true}

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute nickname
      #   @return [String]
      define_attribute :nickname, String

      # @!attribute phone
      #   @return [String]
      define_attribute :phone, String

      # @!attribute postal_code
      #   @return [String] Zip or postal code.
      define_attribute :postal_code, String

      # @!attribute region
      #   @return [String] State or province.
      define_attribute :region, String

      # @!attribute street1
      #   @return [String]
      define_attribute :street1, String

      # @!attribute street2
      #   @return [String]
      define_attribute :street2, String

      # @!attribute [r] updated_at
      #   @return [DateTime] Updated at
      define_attribute :updated_at, DateTime, {:read_only=>true}

      # @!attribute vat_number
      #   @return [String]
      define_attribute :vat_number, String

    end
  end
end

module Recurly
  module Requests
    class Address < Request

      # @!attribute city
      #   @return [String] City
      define_attribute :city, String

      # @!attribute country
      #   @return [String] Country, 2-letter ISO code.
      define_attribute :country, String

      # @!attribute first_name
      #   @return [String] First name
      define_attribute :first_name, String

      # @!attribute last_name
      #   @return [String] Last name
      define_attribute :last_name, String

      # @!attribute phone
      #   @return [String] Phone number
      define_attribute :phone, String

      # @!attribute postal_code
      #   @return [String] Zip or postal code.
      define_attribute :postal_code, String

      # @!attribute region
      #   @return [String] State or province.
      define_attribute :region, String

      # @!attribute street1
      #   @return [String] Street 1
      define_attribute :street1, String

      # @!attribute street2
      #   @return [String] Street 2
      define_attribute :street2, String
    end
  end
end

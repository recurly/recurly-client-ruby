module Recurly
  module Requests
    class AccountCreateOnly < Request

      # @!attribute acquisition
      #   @return [AccountAcquisitionUpdatable]
      define_attribute :acquisition, :AccountAcquisitionUpdatable

      # @!attribute code
      #   @return [String] The unique identifier of the account. This cannot be changed once the account is created.
      define_attribute :code, String

      # @!attribute shipping_addresses
      #   @return [Array[ShippingAddressCreate]]
      define_attribute :shipping_addresses, Array, {:item_type=>:ShippingAddressCreate}

    end
  end
end

module Recurly
  class ShippingFee < Resource
    # @return [ShippingAddress, nil]
    has_one :shipping_address, class_name: :ShippingAddress, readonly: false

    define_attribute_methods %w(
      shipping_method_code
      shipping_amount_in_cents,
      shipping_address_id
    )

    # shipping_amount_in_cents should just be a number rather than a currency
    # See https://github.com/recurly/recurly-client-ruby/blob/3726114fdf584ba50982e0ee28fd219136043fbc/lib/recurly/resource.rb#L751-L753
    def currency
    end
  end
end

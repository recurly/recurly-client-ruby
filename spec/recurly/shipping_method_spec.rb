require 'spec_helper'

describe ShippingMethod do
  describe ".find" do
    it "must return a shipping method when available" do
      stub_api_request(
        :get, 'shipping_methods/fedex_ground', 'shipping_methods/show-200'
      )
      shipping_method = ShippingMethod.find 'fedex_ground'
      shipping_method.must_be_instance_of ShippingMethod
    end
  end
end
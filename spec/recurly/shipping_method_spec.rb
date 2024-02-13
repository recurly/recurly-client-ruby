require 'spec_helper'

describe ShippingMethod do
  describe ".find" do
    before do
      stub_api_request(
        :get, 'shipping_methods/fedex_ground', 'shipping_methods/show-200'
        )
    end
    it "must return a shipping method when available" do
      shipping_method = ShippingMethod.find 'fedex_ground'
      shipping_method.must_be_instance_of ShippingMethod
    end

    it "returns RevRec values" do
      shipping_method = ShippingMethod.find 'fedex_ground'
      shipping_method.performance_obligation_id.must_equal('4')
      shipping_method.revenue_gl_account_id.must_equal('thproqnpcuwp')
      shipping_method.liability_gl_account_id.must_equal('twywqfr48v9l')
    end
  end
end
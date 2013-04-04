require 'spec_helper'

describe BillingInfo do

  describe ".find" do
    it "must return an account's billing info when available" do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      billing_info.must_be_instance_of BillingInfo
      billing_info.first_name.must_equal 'Larry'
      billing_info.last_name.must_equal 'David'
      billing_info.card_type.must_equal 'Visa'
      billing_info.last_four.must_equal '1111'
      billing_info.city.must_equal 'Los Angeles'
      billing_info.state.must_equal 'CA'
    end

    it "must raise an exception when unavailable" do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'accounts/show-404'
      )
      proc { BillingInfo.find 'abcdef1234567890' }.must_raise Resource::NotFound
    end
  end

end

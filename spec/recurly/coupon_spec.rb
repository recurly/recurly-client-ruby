require 'spec_helper'

describe Coupon do
  let(:coupon) { Coupon.find 'bettercallsaul' }

  before do
    stub_api_request :get, 'coupons/bettercallsaul', 'coupons/show-200'
  end

  describe ".find" do
    it "must return a coupon when available" do
      coupon.must_be_instance_of Coupon
    end
  end

  describe "#save" do
    it "must not save a new record" do
      -> { coupon.save }.must_raise Error
    end
  end

  describe "#redeem" do
    it "must be redeemable" do
      stub_api_request(
        :put, "coupons/bettercallsaul/redeem", "redemptions/create-201"
      )
      coupon.redeem 'xX_pinkman_Xx'
    end
  end
end

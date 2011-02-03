require 'spec_helper'

module Recurly
  describe Coupon do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "redeem a coupon" do
      use_vcr_cassette "coupon/create/#{timestamp}"
      let(:account){ Factory.create_account("coupon-create-#{timestamp}") }

      before(:each) do
        @coupon_attributes = { 
          :account_code => account.account_code,
          :coupon_code => 'coupon'
        }
        @coupon = Coupon.create(@coupon_attributes)
      end

      it "should lookup an applied coupon" do
        coupon_lookup = account.coupon
        coupon_lookup.coupon_code.should == @coupon.coupon_code
      end

      it "should successfully apply the coupon to the account" do
        @coupon.coupon_code.should_not be_nil
      end
    end

    describe "remove a coupon" do
      use_vcr_cassette "coupon/destroy/#{timestamp}"
      let(:account){ Factory.create_account("coupon-destroy-#{timestamp}") }

      before(:each) do
        @coupon_attributes = { 
          :account_code => account.account_code,
          :coupon_code => 'coupon'
        }
        @coupon = Coupon.create(@coupon_attributes)
      end

      it "should successfully remove a coupon" do
        @coupon.destroy

        lambda { Coupon.find(account.account_code) }.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end
end

require 'spec_helper'

module Recurly
  describe Credit do

    describe "#create" do
      let(:account){ Factory.create_account('credit-create') }

      before(:each) do
        @credit = Credit.create({
          :account_code => account.account_code,
          :amount => 9.50
        })
      end

      it "should successfully create the credit" do
        @credit.id.should_not be_nil
      end

      it "should set the correct amount" do
        @credit.amount_in_cents.should == -950
      end
    end

    describe "#list" do
      let(:account){ Factory.create_account('credit-list') }
      before(:each) do
        @credit = Credit.create({
          :account_code => account.account_code,
          :amount => 9.32
        })

        @results = Credit.list(account.account_code)
      end

      it "should return successfully" do
        @results.should_not be_nil
      end

      it "should return a single result" do
        @results.size.should == 1
      end

      it "should return the proper results" do
        @results.first.amount_in_cents.should == -932
      end
    end
  end
end
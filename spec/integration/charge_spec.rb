require 'spec_helper'

module Recurly
  describe Charge do
    describe "#create" do
      around(:each){|e| VCR.use_cassette('charge/create', &e)}

      let(:account) { Factory.create_account_with_billing_info("charge-create") }

      before(:each) do
        @charge = Factory.create_charge(account.account_code)
      end

      it "should save successfully" do
        @charge.created_at.should_not be_nil
      end

      it "should set the correct amount" do
        @charge.amount_in_cents.should == 250
      end

      it "should save to the database" do
        charge = Charge.find(@charge.id, :params => {:account_code => account.account_code})
        charge.description.should == @charge.description
      end
    end

    describe "list all charges" do
      around(:each){|e| VCR.use_cassette('charge/all', &e)}

      let(:account) { Factory.create_account("charge-all") }
      before(:each) do
        # TODO
        # create a few sample transactions
      end

      it "should return all the transactions"
    end

    describe "list charges for a specific account" do
      around(:each){|e| VCR.use_cassette('charge/list', &e)}

      let(:account) { Factory.create_account("charge-list") }

      before(:each) do

      end
    end
  end
end
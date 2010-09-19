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
      around(:each){|e| VCR.use_cassette('charge/list', &e)}

      let(:account) { Factory.create_account("charge-list") }
      before(:each) do
        Factory.create_charge(account.account_code)
        Factory.create_charge(account.account_code)
        Factory.create_charge(account.account_code)

        @charges = Charge.list(account.account_code)
      end

      it "should return all the transactions" do
        @charges.length.should == 3
      end
    end

    describe "lookup a charge" do
      around(:each){|e| VCR.use_cassette('charge/lookup', &e)}

      let(:account) { Factory.create_account("charge-lookup") }

      before(:each) do
        @orig_charge = Factory.create_charge(account.account_code)
        @charge = Charge.lookup(account.account_code, @orig_charge.id)
      end

      it "should return the transaction" do
        @charge.should == @orig_charge
      end
    end
  end
end
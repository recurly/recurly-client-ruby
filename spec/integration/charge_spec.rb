require 'spec_helper'

module Recurly
  describe Charge do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    describe "create a charge" do
      around(:each){|e| VCR.use_cassette("charge/create/#{timestamp}", &e)}

      let(:account) { Factory.create_account_with_billing_info("charge-create-#{timestamp}") }

      before(:each) do
        charge = Factory.create_charge account.account_code,
                                        :amount => 2.50,
                                        :description => "virtual cow maintence fee"

        @charge = Charge.lookup(account.account_code, charge.id)
      end

      it "should save successfully" do
        @charge.created_at.should_not be_nil
      end

      it "should set the amount" do
        @charge.amount_in_cents.should == 250
      end

      it "should set the description" do
        @charge.description.should == "virtual cow maintence fee"
      end
    end

    describe "list charges for an account" do
      around(:each){|e| VCR.use_cassette("charge/list/#{timestamp}", &e)}

      let(:account) { Factory.create_account("charge-list-#{timestamp}") }
      before(:each) do
        Factory.create_charge(account.account_code)
        Factory.create_charge(account.account_code)
        Factory.create_charge(account.account_code)

        @charges = Charge.list(account.account_code)
      end

      it "should return all the transactions" do
        @charges.length.should == 3
      end

      it "should also be available via Account#charges" do
        account.charges.should == @charges
      end

    end

    describe "lookup a charge" do
      around(:each){|e| VCR.use_cassette("charge/lookup/#{timestamp}", &e)}

      let(:account) { Factory.create_account("charge-lookup-#{timestamp}") }

      before(:each) do
        charge = Factory.create_charge account.account_code,
                                        :amount => 13.15,
                                        :description => "inconvenience fee"

        @charge = Charge.lookup(account.account_code, charge.id)
      end

      it "should return the correct amount" do
        @charge.amount_in_cents.should == 1315
      end

      it "should return the correct description" do
        @charge.description.should == "inconvenience fee"
      end

      it "should also be available via Account#lookup_charge" do
        account.lookup_charge(@charge.id).should == @charge
      end
    end
  end
end
require 'spec_helper'

module Recurly
  describe Charge do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "list an account's charges" do

      context "all charges" do
        use_vcr_cassette "charge/list-all/#{timestamp}"

        let(:account) { Factory.create_account("charge-list-all-#{timestamp}") }
        before(:each) do
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)

          @charges = Charge.list(account.account_code)
        end

        it "should return all the charges" do
          @charges.length.should == 3
        end

        it "should also be available via Account#charges" do
          account.charges.should == @charges
        end
      end

      context "pending charges" do
        use_vcr_cassette "charge/list-pending/#{timestamp}"

        let(:account) { Factory.create_account("charge-list-pending-#{timestamp}") }
        before(:each) do
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)

          @charges = Charge.list(account.account_code, :pending)
        end

        it "should return all the charges" do
          @charges.length.should == 3
        end

        it "should also be available via Account#charges" do
          account.charges(:pending).should == @charges
        end
      end

      context "invoiced charges" do
        use_vcr_cassette "charge/list-invoiced/#{timestamp}"

        let(:account) { Factory.create_account("charge-list-invoiced-#{timestamp}") }
        before(:each) do
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)
          Factory.create_charge(account.account_code)

          Invoice.create(:account_code => account.account_code)

          Factory.create_charge(account.account_code)

          @charges = Charge.list(account.account_code, :invoiced)
        end

        it "should return all the charges that were invoiced" do
          @charges.length.should == 3
        end

        it "should also be available via Account#charges" do
          account.charges(:invoiced).should == @charges
        end
      end

    end

    describe "charge an account" do
      use_vcr_cassette "charge/create/#{timestamp}"

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

    describe "lookup a charge" do
      use_vcr_cassette "charge/lookup/#{timestamp}"

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

    describe "delete a charge" do
      context "uninvoiced charge" do
        use_vcr_cassette "charge/delete-uninvoiced/#{timestamp}"

        let(:account) { Factory.create_account("charge-delete-uinvoiced-#{timestamp}")}

        before(:each) do
          charge = Factory.create_charge account.account_code,
                                          :amount => 13.15,
                                          :description => "inconvenience fee"

          @charge = Charge.lookup(account.account_code, charge.id)

          @charge.destroy
        end

        it "should remove the charge" do
          expect{
            Charge.lookup(account.account_code, @charge.id)
          }.to raise_error ActiveResource::ResourceNotFound
        end
      end

      context "invoiced charge" do
        use_vcr_cassette "charge/delete-uninvoiced/#{timestamp}"

        let(:account) { Factory.create_account("charge-delete-uinvoiced-#{timestamp}")}

        before(:each) do
          charge = Factory.create_charge account.account_code,
                                          :amount => 13.15,
                                          :description => "inconvenience fee"

          @charge = Charge.lookup(account.account_code, charge.id)
          Invoice.create(:account_code => account.account_code)

        end

        it "should not remove the charge" do
          pending "should not throw a 500 error"
          @charge.destroy.should be_false
          Charge.lookup(account.account_code, @charge.id).should == @charge
        end
      end
    end
  end
end
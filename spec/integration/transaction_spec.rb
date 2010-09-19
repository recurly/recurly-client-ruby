require 'spec_helper'

module Recurly
  describe Transaction do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    describe "create new transaction" do
      context "on an new account" do
        around(:each){|e| VCR.use_cassette("transaction/create-no-account/#{timestamp}", &e)}
        let(:account_code) { "transaction-create-with-accout-#{timestamp}" }

        before(:each) do
          @transaction = Factory.create_full_transaction(account_code)
        end

        it "should save successfully" do
          @transaction.status.should == "success"
          @transaction.errors.should be_empty
        end
      end

      context "with an existing account" do
        around(:each){|e| VCR.use_cassette("transaction/create-with-account/#{timestamp}", &e)}
        let(:account) { Factory.create_account_with_billing_info("transaction-create-with-account-#{timestamp}") }

        before(:each) do
          @transaction = Factory.create_transaction account.account_code,
                                                    :amount => 7.00,
                                                    :description => "test transaction for $7"
        end

        it "should save successfully" do
          @transaction.status.should == "success"
          @transaction.errors.should be_empty
        end
      end
    end

    describe "list all transactions" do
      around(:each){|e| VCR.use_cassette("transaction/all/#{timestamp}", &e)}

      before(:each) do
        @transactions = Transaction.all
      end

      it "should be successful" do
        @transactions.should be_an_instance_of(Array)
      end
    end

    describe "list all transactions for an account" do

      context "empty transactions" do
        around(:each){|e| VCR.use_cassette("transaction/list-empty/#{timestamp}", &e)}
        let(:account) { Factory.create_account("transaction-list-empty-#{timestamp}") }

        before(:each) do
          @transactions = Transaction.list(account.account_code)
        end

        it "should return an empty array of transactions" do
          @transactions.should be_empty
        end
      end

      context "with transactions" do
        around(:each){|e| VCR.use_cassette("transaction/list-filled/#{timestamp}", &e)}
        let(:account) { Factory.create_account("transaction-list-filled-#{timestamp}") }

        before(:each) do
          Factory.create_transaction account.account_code, :amount => 1.00, :description => "one"
          Factory.create_transaction account.account_code, :amount => 2.00, :description => "two"
          Factory.create_transaction account.account_code, :amount => 3.00, :description => "three"

          @transactions = Transaction.list(account.account_code)
        end

        it "should return a list of transactions made on the account" do
          @transactions.length.should == 3
        end
      end
    end
  end
end
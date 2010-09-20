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
          @transaction = Factory.create_full_transaction account_code,
                                                          :amount_in_cents => 700,
                                                          :description => "setup fee of 7 dollarz"
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
                                                     :amount_in_cents => 700,
                                                     :description => "test transaction for $7"
        end

        it "should save successfully" do
          @transaction.status.should == "success"
          @transaction.errors.should be_empty
        end
      end
    end

    describe "find all transactions" do
      around(:each){|e| VCR.use_cassette("transaction/all/#{timestamp}", &e)}

      before(:each) do
        @transactions = Transaction.all
      end

      it "should be successful" do
        @transactions.should be_an_instance_of(Array)
      end
    end

    describe "list account transactions" do
      context "empty transactions" do
        around(:each){|e| VCR.use_cassette("transaction/list-empty/#{timestamp}", &e)}
        let(:account) { Factory.create_account_with_billing_info("transaction-list-empty-#{timestamp}") }

        before(:each) do
          @transactions = Transaction.list(account.account_code)
        end

        it "should return an empty array of transactions" do
          @transactions.should be_empty
        end
      end

      context "with transactions" do
        around(:each){|e| VCR.use_cassette("transaction/list-filled/#{timestamp}", &e)}
        let(:account) { Factory.create_account_with_billing_info("transaction-list-filled-#{timestamp}") }

        before(:each) do
          Factory.create_transaction account.account_code, :amount_in_cents => 100, :description => "one"
          Factory.create_transaction account.account_code, :amount_in_cents => 200, :description => "two"
          Factory.create_transaction account.account_code, :amount_in_cents => 300, :description => "three"

          @successful_transactions = Transaction.list(account.account_code, :success)
        end

        it "should return a list of transactions made on the account" do
          @successful_transactions.length.should == 3
        end

        it "should also be available via Account#transactions" do
          account.transactions(:success).should == @successful_transactions
        end

      end
    end

    describe "lookup account transaction" do
      around(:each){|e| VCR.use_cassette("transaction/lookup/#{timestamp}", &e)}
      let(:account) { Factory.create_account_with_billing_info("transaction-lookup-#{timestamp}") }

      before(:each) do
        t1 = Factory.create_transaction account.account_code, :amount_in_cents => 100, :description => "one"
        t2 = Factory.create_transaction account.account_code, :amount_in_cents => 200, :description => "two"
        t3 = Factory.create_transaction account.account_code, :amount_in_cents => 300, :description => "three"

        @transaction1 = Transaction.lookup(account.account_code, t1.id)
        @transaction2 = Transaction.lookup(account.account_code, t2.id)
        @transaction3 = Transaction.lookup(account.account_code, t3.id)
      end

      it "should the transaction details" do
        @transaction2.amount_in_cents.should == 200
      end

      it "should also be available via Account#lookup_transaction" do
        account.lookup_transaction(@transaction3.id).should == @transaction3
      end

    end

  end
end
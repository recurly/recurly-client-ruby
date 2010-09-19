require 'spec_helper'

module Recurly
  describe Transaction do
    describe "create new transaction" do
      around(:each){|e| VCR.use_cassette('transaction/create', &e)}

      let(:account) { Factory.create_account_with_billing_info("transaction-create") }

      before(:each) do
        @transaction = Transaction.new({
          :account => {
            :account_code => account.account_code
          },
          :amount_in_cents => 700,
          :description => "test transaction for $7"
        })
        @transaction.save!
      end

      it "should save successfully" do
        @transaction.should_not be_nil
        @transaction.errors.should be_empty
      end
    end

    describe "list all transactions" do
      around(:each){|e| VCR.use_cassette('transaction/all', &e)}

      before(:each) do
        @transactions = Transaction.all
      end

      it "should be successful" do
        @transactions.should be_an_instance_of(Array)
      end
    end

    describe "list all transactions for an account" do
      around(:each){|e| VCR.use_cassette('transaction/list', &e)}

      context "empty" do
        let(:account) { Factory.create_account("transaction-list-empty") }

        before(:each) do
          @transactions = Transaction.list(account.account_code)
        end

        it "should return an empty array of transactions" do
          @transactions.should be_empty
        end
      end
    end
  end
end
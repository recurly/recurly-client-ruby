require 'spec_helper'

module Recurly
  describe Transaction do
    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette('transaction/create', &example)
      end

      let(:account) { Factory.create_account_with_billing_info("transaction-create") }

      before(:each) do
        pending "Transaction create API is borked"
        @transaction = Transaction.create({
          :account => {
            :account_code => account.account_code
          },
          :amount_in_cents => 500,
          :description => "test transaction for $5"
        })
      end

      it "should save successfully" do
        @transaction.should_not be_nil
        @transaction.errors.should be_empty
      end

      it "should set the correct amount" do
        @transaction.amount_in_cents.should == 500
      end

      it "should save the record" do
        pending "Not Yet Implemented"
        # Transaction.all.length.should == 1
      end
    end

    describe "#list" do
      around(:each) do |example|
        VCR.use_cassette('transaction/list', &example)
      end

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
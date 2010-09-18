require 'spec_helper'

module Recurly
  describe Charge do
    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette('charge/create', &example)
      end

      let(:account) { Factory.create_account_with_billing_info("charge-create") }

      before(:each) do
        # TODO: create a charge
      end

      it "should save successfully"
      it "should set the correct amount"
      it "should save the record"
    end

    describe "#all" do
      around(:each) do |example|
        VCR.use_cassette('charge/all', &example)
      end

      let(:account) { Factory.create_account("charge-all") }
      before(:each) do
        # TODO
        # create a few sample transactions
      end

      it "should return all the transactions"
    end
  end
end
require 'spec_helper'

module Recurly
  describe Invoice do
    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette('invoice/create', &example)
      end

      let(:account) { Factory.create_account("invoice-create") }

      before(:each) do
        # TODO: create a few charges on the account
        @invoice = Invoice.create(:account_code => account.account_code)
      end

      it "should save successfully" do
        @invoice
        pending
      end
    end

    describe "#find" do
      around(:each) do |example|
        VCR.use_cassette('invoice/find', &example)
      end

      let(:account) { Factory.create_account("invoice-find") }
      before(:each) do
        # TODO
        # create a few sample charges and invoices
      end

      it "should return the invoice"
    end
  end
end
require 'spec_helper'

module Recurly
  describe Invoice do
    describe "#create" do
      around(:each){|e| VCR.use_cassette('invoice/create', &e)}

      let(:account) { Factory.create_account_with_billing_info("invoice-create") }

      before(:each) do
        @invoice = Invoice.create(:account_code => account.account_code)
      end

      it "should save successfully" do
        @invoice
        pending "Not yet implemented"
      end
    end

    describe "#find" do
      around(:each){|e| VCR.use_cassette('invoice/find', &e)}

      let(:account) { Factory.create_account("invoice-find") }
      before(:each) do
        # TODO
        # create a few sample charges and invoices
      end

      it "should return the invoice"
    end
  end
end
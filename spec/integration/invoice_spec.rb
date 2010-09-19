require 'spec_helper'

module Recurly
  describe Invoice do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    describe "#create" do
      around(:each){|e| VCR.use_cassette("invoice/create/#{timestamp}", &e)}

      let(:account) { Factory.create_account_with_billing_info("invoice-create-#{timestamp}") }

      before(:each) do
        @invoice = Invoice.create(:account_code => account.account_code)
      end

      it "should save successfully" do
        @invoice
        pending "Not yet implemented"
      end
    end

    describe "#find" do
      around(:each){|e| VCR.use_cassette("invoice/find/#{timestamp}", &e)}

      let(:account) { Factory.create_account("invoice-find-#{timestamp}") }
      before(:each) do
        # TODO
        # create a few sample charges and invoices
      end

      it "should return the invoice"
    end
  end
end
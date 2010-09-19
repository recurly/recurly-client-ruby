require 'spec_helper'

module Recurly
  describe Invoice do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    def create_sample_charges(account)
      Factory.create_charge(account.account_code, :amount => 5.00)
      Factory.create_charge(account.account_code, :amount => 10.00)
      Factory.create_charge(account.account_code, :amount => 15.00)
    end

    describe "#create" do
      around(:each){|e| VCR.use_cassette("invoice/create/#{timestamp}", &e)}

      let(:account) { Factory.create_account_with_billing_info("invoice-create-#{timestamp}") }
      before(:each) do
        create_sample_charges(account)
        @invoice = Invoice.create(:account_code => account.account_code)
      end

      it "should save successfully" do
        @invoice.total_in_cents.should == 3000
        @invoice.line_items.length.should == 3
      end
    end

    describe "#find" do
      around(:each){|e| VCR.use_cassette("invoice/find/#{timestamp}", &e)}

      let(:account) { Factory.create_account("invoice-find-#{timestamp}") }
      before(:each) do
        create_sample_charges(account)
        invoice = Invoice.create(:account_code => account.account_code)
        @invoice = Invoice.find(invoice.id)
      end

      it "should return the invoice" do
        @invoice.total_in_cents.should == 3000
        @invoice.line_items.length.should == 3
      end
    end
  end
end
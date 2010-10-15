require 'spec_helper'

module Recurly
  describe Invoice do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    def create_sample_charges(account)
      Factory.create_charge(account.account_code, :amount => 10.00)
      Factory.create_charge(account.account_code, :amount => 15.00)
    end

    describe "creating an invoice" do
      context "with charges" do
        use_vcr_cassette "invoice/create/#{timestamp}"

        let(:account) { Factory.create_account_with_billing_info("invoice-create-#{timestamp}") }
        before(:each) do
          create_sample_charges(account)
          @invoice = Invoice.create(:account_code => account.account_code)
        end

        it "should save successfully" do
          @invoice.total_in_cents.should == 2500
          @invoice.line_items.length.should == 2
        end
      end

      context "without charges" do
        use_vcr_cassette "invoice/create-no-charges/#{timestamp}"

        let(:account) { Factory.create_account_with_billing_info("invoice-create-no-charges-#{timestamp}") }

        it "should not be created since no charges were posted" do
          @invoice = Invoice.create(:account_code => account.account_code)
          @invoice.should_not be_valid
        end
      end
    end

    describe "listing invoices" do
      use_vcr_cassette "invoice/list/#{timestamp}"

      let(:account) { Factory.create_account_with_billing_info("invoice-list-#{timestamp}") }
      before(:each) do
        Factory.create_charge(account.account_code, :amount => 1.00)
        invoice = Invoice.create(:account_code => account.account_code)

        Factory.create_charge(account.account_code, :amount => 3.00)
        invoice = Invoice.create(:account_code => account.account_code)

        @invoices = Invoice.list(account.account_code)
      end

      it "should return the list of invoices" do
        @invoices.length.should == 2
      end

      it "should also be available via Account#invoices" do
        account.invoices.should == @invoices
      end

    end

    describe "looking up an invoice" do
      use_vcr_cassette "invoice/lookup/#{timestamp}"

      let(:account) { Factory.create_account_with_billing_info("invoice-lookup-#{timestamp}") }
      before(:each) do
        Factory.create_charge(account.account_code, :amount => 15.00)
        invoice = Invoice.create(:account_code => account.account_code)
        @invoice = Invoice.lookup(account.account_code, invoice.id)
      end

      it "should return the invoice" do
        @invoice.total_in_cents.should == 1500
        @invoice.line_items.length.should == 1
      end

      it "should also be available via Account#lookup_invoice" do
        account.lookup_invoice(@invoice.id).should == @invoice
      end

    end
  end
end
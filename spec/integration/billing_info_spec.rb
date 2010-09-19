require 'spec_helper'

module Recurly
  describe BillingInfo do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    def verify_billing_info(billing_info, billing_attributes)
      # check the billing data fields
      billing_info.first_name.should == billing_attributes[:first_name]
      billing_info.last_name.should == billing_attributes[:last_name]
      billing_info.address1.should == billing_attributes[:address1]
      billing_info.city.should == billing_attributes[:city]
      billing_info.state.should == billing_attributes[:state]
      billing_info.zip.should == billing_attributes[:zip]

      # check the credit card fields
      billing_info.credit_card.last_four.should == billing_attributes[:credit_card][:number]
    end

    describe "#create" do
      around(:each){|e| VCR.use_cassette("billing/create/#{timestamp}", &e)}
      let(:account){ Factory.create_account("billing-create-#{timestamp}") }

      before(:each) do
        @billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name
        })

        @billing_info = BillingInfo.create(@billing_attributes)
      end

      it "should successfully create the billing info record" do
        @billing_info.updated_at.should_not be_nil
      end

      it "should set the correct billing_info on the server " do
        billing_info = BillingInfo.find(account.account_code)
        verify_billing_info(billing_info, @billing_attributes)
      end
    end

    describe "#find" do
      around(:each){|e| VCR.use_cassette("billing/find/#{timestamp}", &e)}
      let(:account){ Factory.create_account_with_billing_info("billing-find-#{timestamp}") }

      before(:each) do
        @billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name
        })

        @billing_info = BillingInfo.find(account.account_code)
      end

      it "should return the correct billing_info from the server" do
        billing_info = BillingInfo.find(account.account_code)
        verify_billing_info(billing_info, @billing_attributes)
      end
    end

  end
end
require 'spec_helper'

module Recurly
  describe BillingInfo do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    def verify_billing_info(billing_info, billing_attributes)
      # check the billing data fields
      billing_info.first_name.should == billing_attributes[:first_name]
      billing_info.last_name.should == billing_attributes[:last_name]
      billing_info.address1.should == billing_attributes[:address1]
      billing_info.city.should == billing_attributes[:city]
      billing_info.state.should == billing_attributes[:state]
      billing_info.zip.should == billing_attributes[:zip]

      # check the credit card fields
      billing_info.credit_card.last_four.should == billing_attributes[:credit_card][:number][-4, 4]
    end

    describe "create an account's billing information" do
      use_vcr_cassette "billing/create/#{timestamp}"
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

    describe "update an account's billing information" do
      use_vcr_cassette "billing/update/#{timestamp}"
      let(:account){ Factory.create_account_with_billing_info("billing-update-#{timestamp}") }

      before(:each) do
        @new_billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name,
          :address1 => "1st Ave South, Apt 5001"
        })

        @billing_info = BillingInfo.create(@new_billing_attributes)
      end

      it "should set the correct billing_info on the server " do
        billing_info = BillingInfo.find(account.account_code)
        verify_billing_info(billing_info, @new_billing_attributes)
      end
    end

    describe "get account's billing information" do
      use_vcr_cassette "billing/find/#{timestamp}"
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

    describe "clearing an account's billing information" do
      use_vcr_cassette "billing/destroy/#{timestamp}"
      let(:account){ Factory.create_account("billing-destroy-#{timestamp}") }

      before(:each) do
        @billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name,
          :address1 => "500 South Central Blvd",
          :city => "Los Angeles",
          :state => "CA",
          :zip => "90001"
        })

        BillingInfo.create(@billing_attributes)

        @billing_info = BillingInfo.find(account.account_code)
      end

      it "should allow destroying the billing info for an account" do
        @billing_info.destroy

        expect {
          fresh = BillingInfo.find(account.account_code)
        }.to raise_error ActiveResource::ResourceNotFound
      end
    end
    
    describe "set the appropriate error" do
      use_vcr_cassette "billing/errors/#{timestamp}"
      let(:account){ Factory.create_account("billing-errors-#{timestamp}") }

      it "should set an error on base if the card number is blank" do
        @billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name,
          :credit_card => {
            :number => '',
          },
        })

        billing_info = BillingInfo.create(@billing_attributes)
        billing_info.errors[:base].count.should == 1
      end
      
      it "should set an error if the card number is invalid" do
        @billing_attributes = Factory.billing_attributes({
          :account_code => account.account_code,
          :first_name => account.first_name,
          :last_name => account.last_name,
          :credit_card => {
            :number => '4000-0000-0000-0002',
          },
        })

        billing_info = BillingInfo.create(@billing_attributes)
        billing_info.errors.count.should == 1
      end
    end
  end
end
require 'spec_helper'

module Recurly
  describe BillingInfo do

    let(:account){ Factory.create_account('billing') }

    let(:billing_info_attributes) do
      {
        :account_code => account.account_code,
        :first_name => account.first_name,
        :last_name => account.last_name,
        :address1 => '123 Test St',
        :city => 'San Francisco',
        :state => 'CA',
        :zip => '94115',
        :credit_card => {
          :number => '1',
          :year => Time.now.year + 1,
          :month => Time.now.month,
          :verification_value => '123'
        }
      }
    end

    before(:each) do
      @billing_info = BillingInfo.create(billing_info_attributes)
    end

    it "should successfully create the billing info record" do
      @billing_info.updated_at.should_not be_nil
    end

    it "should return the updated data from the server" do
      billing_info = BillingInfo.find(account.account_code)

      # check the billing data fields
      billing_info.first_name.should == billing_info_attributes[:first_name]
      billing_info.last_name.should == billing_info_attributes[:last_name]
      billing_info.address1.should == billing_info_attributes[:address1]
      billing_info.city.should == billing_info_attributes[:city]
      billing_info.state.should == billing_info_attributes[:state]
      billing_info.zip.should == billing_info_attributes[:zip]

      # check the credit card fields
      billing_info.credit_card.last_four.should == billing_info_attributes[:credit_card][:number]
      billing_info.credit_card.month.should == billing_info_attributes[:credit_card][:month]
      billing_info.credit_card.year.should == billing_info_attributes[:credit_card][:year]
    end

  end
end
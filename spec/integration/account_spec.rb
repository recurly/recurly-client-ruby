require 'spec_helper'

module Recurly
  describe Account do
    timestamp = File.mtime(__FILE__).to_i

    describe "#new" do
      let(:attributes) { Factory.account_attributes("account-new-#{timestamp}") }
      before(:each) do
        @account = Account.new(attributes)
      end

      it "should be valid" do
        @account.should be_valid
      end

      it "should set the attributes correctly" do
        attributes.each do |key, val|
          @account.attributes[key].should == val
        end
      end
    end

    describe "#create" do
      context "with full data" do
        use_vcr_cassette "account/create/#{timestamp}"

        let(:attributes) { Factory.account_attributes("account-create-#{timestamp}") }
        before(:each) do
          @account = Account.create(attributes)
        end

        it "should be valid" do
          @account.should be_valid
        end

        it "should set a created_at date from the server" do
          @account.created_at.should_not be_nil
        end

        it "should set a hosted_login_token from the server" do
          @account.hosted_login_token.should_not be_nil
        end

        it "should set the balance to 0" do
          @account.balance_in_cents.should == 0
        end

        it "should set the account status to active" do
          @account.state.should == "active"
          @account.closed?.should be_false
        end
      end

      context "with just account-code" do
        use_vcr_cassette "account/create-min/#{timestamp}"

        before(:each) do
          @account = Account.create(:account_code => "d00d-#{timestamp}")
        end

        it "should be valid" do
          @account.should be_valid
        end

        it "should set a created_at date from the server" do
          @account.created_at.should_not be_nil
        end

      end
    end

    describe "#find" do
      use_vcr_cassette "account/find/#{timestamp}"
      let(:orig){ Factory.create_account("account-get-#{timestamp}") }

      before(:each) do
        @account = Account.find(orig.account_code)
      end

      it "should return the account object" do
        @account.should_not be_nil
      end

      describe "returned account" do
        it "should have a created_at date" do
          @account.created_at.should_not be_nil
        end

        it "should match the original account code" do
          @account.account_code.should == orig.account_code
        end

        it "should match the original account email" do
          @account.email.should == orig.email
        end

        it "should match the original first name" do
          @account.first_name.should == orig.first_name
        end
      end

      context "looking for a non-existant account" do
        it "should raise an ActiveResource::ResourceNotFound exception" do
          expect {
            Account.find('account-that-doesnt-exist')
          }.to raise_error ActiveResource::ResourceNotFound
        end
      end
    end


    # spec list queries for finding acocunts
    describe "#list" do
      use_vcr_cassette "account/list/#{timestamp}"

      before(:each) do

        # create new ones
        @accounts = []
        8.times do |i|
          @accounts << Factory.create_account("account-list-num-#{i}-#{timestamp}")
        end

        # mark the 4 of them as paid
        @subscriptions = []
        @accounts[0, 4].each do |account|
          @subscriptions << Factory.create_subscription(account, :paid)
        end
      end

      it "should return a list of accounts with matching criteria" do
        Account.list(:all).total_entries.should >= 8
        Account.list(:paid).total_entries.should >= 4
        Account.list(:free).total_entries.should >= 4
      end

    end


    describe "#update" do
      use_vcr_cassette "account/update/#{timestamp}"

      let(:orig){ Factory.create_account("account-update-#{timestamp}") }

      before(:each) do
        # update account data
        @account = Account.find(orig.account_code)
        @account.last_name = "Update Test"
        @account.company_name = "Recurly Ruby Gem -- Update"
        @account.save!

        # refetch account
        @account = Account.find(orig.account_code)
      end

      it "should not have updated the email address" do
        @account.email.should == orig.email
      end

      it "should have updated the last_name" do
        @account.last_name.should == "Update Test"
      end

      it "should have updated the company_name" do
        @account.company_name.should == "Recurly Ruby Gem -- Update"
      end
    end

    # EDITING ACCOUNT_CODE NOT YET SUPPORTED ON RECURLY API
    # describe "#update with account_code" do
    #   use_vcr_cassette "account/update2/#{timestamp}"
    #
    #   let(:orig){ Factory.create_account("account-update2-#{timestamp}") }
    #
    #   let(:new_account_code){ "#{orig.account_code}-edited" }
    #
    #   before(:each) do
    #     # update account data
    #     @account = Account.find(orig.account_code)
    #     @account.account_code = new_account_code
    #     @account.save!
    #
    #     @account = Account.find(new_account_code)
    #   end
    #
    #   it "should update the account code" do
    #     @account.account_code.should == new_account_code
    #   end
    # end

    describe "#close_account" do
      use_vcr_cassette "account/close/#{timestamp}"
      let(:account){ Factory.create_account("account-close-#{timestamp}") }

      before(:each) do
        account.close_account

        # load a fresh account
        @account = Account.find(account.account_code)
      end

      it "should mark the account as closed" do
        @account.state.should == "closed"
        @account.closed?.should be_true
      end
    end

    describe "validations" do
      context "with blank data" do
        use_vcr_cassette "account/create-blank/#{timestamp}"

        before(:each) do
          @account = Account.create({:account_code => ""})
        end

        it "should not be valid" do
          @account.should_not be_valid
        end

        it "should require setting an account code" do
          @account.errors[:account_code].should include("can't be blank")
          @account.errors[:account_code].should include("is invalid")
        end
      end

      context "with duplicate data" do
        use_vcr_cassette "account/create-duplicate/#{timestamp}"

        before(:each) do
          Account.create({:account_code => "account-exists"})
          @account = Account.create({:account_code => "account-exists"})
        end

        it "should not be valid" do
          @account.should_not be_valid
        end

        it "should require setting an account code" do
          @account.errors[:account_code].should include("has already been taken")
        end
      end
    end

  end
end
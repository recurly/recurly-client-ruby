require 'spec_helper'

module Recurly
  describe Credit do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe "credit an account" do
      use_vcr_cassette "credit/create/#{timestamp}"

      let(:account){ Factory.create_account("credit-create-#{timestamp}") }

      before(:each) do
        credit = Factory.create_credit account.account_code,
                                        :amount => 10.05,
                                        :description => "free moniez"

        @credit = Credit.lookup(account.account_code, credit.id)
      end

      it "should save successfully" do
        @credit.created_at.should_not be_nil
      end

      it "should set the amount" do
        @credit.amount_in_cents.should == -1005
      end

      it "should set the description" do
        @credit.description.should == "free moniez"
      end
    end

    describe "list an account's credits" do
      use_vcr_cassette "credit/list/#{timestamp}"
      let(:account){ Factory.create_account("credit-list-#{timestamp}") }

      before(:each) do
        Factory.create_credit(account.account_code, :amount => 1, :description => "one")
        Factory.create_credit(account.account_code, :amount => 2, :description => "two")
        Factory.create_credit(account.account_code, :amount => 3, :description => "three")
        @credits = Credit.list(account.account_code)
      end

      it "should return results" do
        @credits.length.should == 3
      end

      it "amounts should be correct" do
        @credits.map{|c| c.amount_in_cents}.should == [-300, -200, -100]
      end

      it "descriptions should be correct" do
        @credits.map{|c| c.description}.should == ["three", "two", "one"]
      end

      it "should also be available via Account#credits" do
        account.credits.should == @credits
      end
    end

    describe "lookup a credit" do
      use_vcr_cassette "credit/lookup/#{timestamp}"
      let(:account) { Factory.create_account("credit-lookup-#{timestamp}") }

      before(:each) do
        credit = Factory.create_credit account.account_code,
                                        :amount => 13.15,
                                        :description => "free moniez 4 u"
        @credit = Credit.lookup(account.account_code, credit.id)
      end

      it "should return the correct amount" do
        @credit.amount_in_cents.should == -1315
      end

      it "should return the correct description" do
        @credit.description.should == "free moniez 4 u"
      end

      it "should also be available via Account#lookup_credit" do
        account.lookup_credit(@credit.id).should == @credit
      end
    end

    describe "delete credit" do
      use_vcr_cassette "credit/delete/#{timestamp}"
      let(:account) { Factory.create_account("delete-uninvoiced-#{timestamp}") }

      before(:each) do
        credit = Factory.create_credit account.account_code,
                                        :amount => 13.15,
                                        :description => "free moniez 4 u"
        @credit = Credit.lookup(account.account_code, credit.id)

        @credit.destroy
      end

      it "should remove the credit" do
        expect {
          Credit.lookup(account.account_code, @credit.id)
        }.to raise_error ActiveResource::ResourceNotFound
      end
    end
  end
end
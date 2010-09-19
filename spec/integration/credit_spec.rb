require 'spec_helper'

module Recurly
  describe Credit do
    # version accounts based on this current files modification dates
    let(:timestamp) { File.mtime(__FILE__).to_i }

    describe "create a credit" do
      around(:each){|e| VCR.use_cassette("credit/create/#{timestamp}", &e)}

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

    describe "list credits for an account" do
      around(:each){|e| VCR.use_cassette("credit/list/#{timestamp}", &e)}
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
    end

    describe "lookup a credit" do
      around(:each){|e| VCR.use_cassette("credit/lookup/#{timestamp}", &e)}
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

    end
  end
end
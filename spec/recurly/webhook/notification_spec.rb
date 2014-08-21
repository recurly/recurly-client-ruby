require 'spec_helper'

describe Webhook::Notification do
  let(:notification) {
    Class.new Webhook::Notification do
      has_one :account
    end
  }
  
  describe ".has_one" do
    it "must define has_one from the Resource superclass" do
      notification.new.must_respond_to :account
    end
    
    it "must define has_one reload method" do
      notification.new.must_respond_to :account!
    end
  end
  
  describe "has_one reload method" do
    let(:account) { Account.new :account_code => 'code' }
    let(:instance) { notification.new(account: account) }
    
    before do
      stub_api_request :any, 'accounts/code', 'accounts/show-200'
    end
    
    it "must find an account" do
      instance.account!.must_be_instance_of Account
    end
    
    it "must find the latest version" do
      instance.account!.account_code.must_equal 'abcdef1234567890'
    end
    
    it "wont return the existing account information" do
      account = instance.account.dup
      instance.account!.wont_equal account
    end
    
    it "must update the existing account information" do
      instance.account!.must_equal instance.account
    end
    
    it "must handle missing accounts" do
      notification.new.account!.must_be :nil?
    end
  end
end

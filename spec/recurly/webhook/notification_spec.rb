require 'spec_helper'

describe Webhook::Notification do
  let(:notification) {
    klass = Class.new Resource do
      attr_reader :reloaded
    
      def reload
        @reloaded = true
        self
      end
    end
    Recurly.const_set :MockAccount, klass
  
    Class.new Webhook::Notification do
      has_one :mock_account
    end
  }
  
  describe ".has_one" do
    it "must define has_one from the Resource superclass" do
      notification.new.must_respond_to :mock_account
    end
    
    it "must define has_one reload method" do
      notification.new.must_respond_to :mock_account!
    end
  end
  
  describe "has_one reload method" do
    let(:instance) { notification.new :mock_account => MockAccount.new }
    
    it "must call reload on the object" do
      account = instance.mock_account!
      account.reloaded.must_equal true
    end
    
    it "must handle nil objects" do
      notification.new.mock_account!.must_be_nil
    end
  end
end

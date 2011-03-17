require 'spec_helper'

module Recurly
  describe Transparent do
    before(:each) do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/recurly.yml")
    end

    describe ".url" do
      it "should return the url for the configured Recurly site" do
        Transparent.url.should == "#{Recurly::Base.site}/transparent/#{Recurly.subdomain}/subscription"
      end

      it "should allow passing in the type of action" do
        Transparent.url(Action::CreateSubscription).should == "#{Recurly::Base.site}/transparent/#{Recurly.subdomain}/subscription"
        Transparent.url(Action::UpdateBilling).should == "#{Recurly::Base.site}/transparent/#{Recurly.subdomain}/billing_info"
        Transparent.url(Action::CreateTransaction).should == "#{Recurly::Base.site}/transparent/#{Recurly.subdomain}/transaction"
      end
    end

    describe ".encrypt_string" do
      it "should encrypt the data using the configured private key" do
        result = Transparent.encrypt_string("d00d")

        # hashed manually
        result.should == "938f381f79192f536cbe29a79db5c595b7a09379"

        result2 = Transparent.encrypt_string("d00d2")
        result2.should_not eq(result)

        result3 = Transparent.encrypt_string("d00d")
        result3.should eq(result)
      end
    end

    describe "#encoded_data" do
      it "should return a data string for use within an input hidden field" do

        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => 'howdy' },
          :value => "hello"
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :account => { :account_code => 'howdy' },
          :value => "hello"
        })

        transparent.encoded_data.split("|").last.should eq(query_string)
      end

      it "should allow fixnums" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :amount => 10
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :amount => 10
        })

        transparent.encoded_data.split("|").last.should == query_string
      end

      it "should allow nested fixnums" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :transaction => {
            :amount => 10
          }
        })

        transparent.encoded_data.split("|").last.should == query_string
      end

      it "should prepend the validation string" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :transaction => {
            :amount => 10
          }
        })

        validation_string = Transparent.encrypt_string(query_string)

        transparent.encoded_data.split("|").first.should == validation_string
      end
    end

    describe "#hidden_field" do
      it "should return a string of a HTML hidden input element" do

        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => 'howdy' },
          :value => "hello"
        })

        transparent.hidden_field.class.should eq(String)
      end

      it "should return a string of a HTML hidden input element" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :amount => 10
        })

        transparent.hidden_field.class.should eq(String)
      end

      it "should return a string of a HTML hidden input element" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :account => { :account_code => '123' },
          :transaction => {
            :amount => 10
          }
        })

        transparent.hidden_field.class.should eq(String)
      end
    end

  end
end

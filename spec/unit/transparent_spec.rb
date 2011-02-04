require 'spec_helper'

module Recurly
  describe Transparent do
    before(:each) do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test.yml")
    end

    describe ".url" do
      it "should return the url for the configured Recurly site" do
        site_url = Recurly.site
        Transparent.url.should == "#{site_url}/transparent/create_subscription"
      end

      it "should allow passing in the type of action" do
        site_url = Recurly.site
        Transparent.url(Action::CreateSubscription).should == "#{site_url}/transparent/create_subscription"
        Transparent.url(Action::UpdateBilling).should == "#{site_url}/transparent/update_billing"
        Transparent.url(Action::CreateTransaction).should == "#{site_url}/transparent/create_transaction"
      end
    end

    describe ".encrypt_string" do
      it "should encrypt the data using the configured private key" do
        result = Transparent.encrypt_string("d00d")

        # hashed manually
        result.should == "4ad64700275cbdc8417857a12cbe11842a5577fb"

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
          :value => "hello"
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :value => "hello"
        })

        transparent.encoded_data.split("|").last.should eq(query_string)
      end

      it "should allow fixnums" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :amount => 10
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :amount => 10
        })

        transparent.encoded_data.split("|").last.should == query_string
      end

      it "should allow nested fixnums" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :transaction => {
            :amount => 10
          }
        })

        transparent.encoded_data.split("|").last.should == query_string
      end

      it "should prepend the validation string" do
        transparent = Transparent.new({
          :redirect_url => "http://example.com/",
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :redirect_url => "http://example.com/",
          :transaction => {
            :amount => 10
          }
        })

        validation_string = Transparent.encrypt_string(query_string)

        transparent.encoded_data.split("|").first.should == validation_string
      end
    end

  end
end

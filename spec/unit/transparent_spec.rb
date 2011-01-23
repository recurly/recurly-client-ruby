require 'spec_helper'

module Recurly
  describe Transparent do
    before(:each) do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test.yml")
    end

    describe ".url" do
      it "should return the url for the configured Recurly site" do
        site_url = Recurly.site
        Transparent.url.should == "#{site_url}/transparent"
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

    describe ".transport" do
      it "should return a transport string for use within an input hidden field" do
        transport_string = Transparent.transport({
          :value => "hello"
        })

        query_string = Transparent.query_string({
          :value => "hello"
        })

        transport_string.split("|").last.should eq(query_string)
      end

      it "should allow fixnums" do
        transport_string = Transparent.transport({
          :amount => 10
        })

        query_string = Transparent.query_string({
          :amount => 10
        })

        transport_string.split("|").last.should == query_string
      end

      it "should allow nested fixnums" do
        transport_string = Transparent.transport({
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :transaction => {
            :amount => 10
          }
        })

        transport_string.split("|").last.should == query_string
      end

      it "should prepend the validation string" do
        transport_string = Transparent.transport({
          :transaction => {
            :amount => 10
          }
        })

        query_string = Transparent.query_string({
          :transaction => {
            :amount => 10
          }
        })

        validation_string = Transparent.encrypt_string(query_string)

        transport_string.split("|").first.should == validation_string
      end
    end

  end
end

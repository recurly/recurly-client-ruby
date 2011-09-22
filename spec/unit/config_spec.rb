require 'spec_helper'

describe "RecurlyConfig" do

  context "loading from YML" do
    it "should load traditional configuration from a YML file" do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test1.yml")
      Recurly.api_key.should == "asdf4jk31"
      Recurly.subdomain.should == "site1"
    end
    
    it "should load configuration from a YML file based on running environment" do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test2.yml")
      Recurly.api_key.should == "asdf4jk32"
      Recurly.subdomain.should == "site2"
    end
  end

  context "loading from json" do
    it "should load configuration from a json config string" do
      Recurly.configure_from_json({
        :api_key => "somepass",
        :subdomain => 'recurlytest3-test',
      }.to_json)
      Recurly.api_key.should == "somepass"
      Recurly.subdomain.should == 'recurlytest3-test'
      Recurly::Base.site.to_s.should == "https://api.recurly.com"

      # test with some crazy chars in the password
      Recurly.configure_from_json({
        :api_key => "*$&!!::@&!)*)*_",
        :subdomain => "recurlytest3-test",
      }.to_json)

      Recurly.api_key.should == "*$&!!::@&!)*)*_"
      Recurly::Base.user.should == Recurly.api_key
      Recurly.subdomain.should == 'recurlytest3-test'
      Recurly::Base.site.to_s.should == "https://api.recurly.com"
    end

  end
end
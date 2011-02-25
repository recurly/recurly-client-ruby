require 'spec_helper'

describe "RecurlyConfig" do

  context "loading from YML" do
    it "should load traditional configuration from a YML file" do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test1.yml")
      Recurly.username.should == "username1@recurly.com"
      Recurly.password.should == "asdf4jk31"
      Recurly.subdomain.should == "site1"
    end
    
    it "should load configuration from a YML file based on running environment" do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test2.yml")
      Recurly.username.should == "username2@recurly.com"
      Recurly.password.should == "asdf4jk32"
      Recurly.subdomain.should == "site2"
    end
  end

  context "loading from json" do
    it "should load configuration from a json config string" do
      Recurly.configure_from_json({
        :username => "someuser@heroku.com",
        :password => "somepass",
        :environment => :sandbox,
        :subdomain => 'recurlytest3-test',
      }.to_json)
      Recurly.username.should == "someuser@heroku.com"
      Recurly.password.should == "somepass"
      Recurly.subdomain.should == 'recurlytest3-test'
      Recurly::Base.site.to_s.should == "https://api-sandbox.recurly.com"

      # test with some crazy chars in the password
      Recurly.configure_from_json({
        :username => "api-someuser@heroku.com",
        :password => "*$&!!::@&!)*)*_",
        :subdomain => "recurlytest3-test",
        :environment => :sandbox,
      }.to_json)

      Recurly.username.should == "api-someuser@heroku.com"
      Recurly.password.should == "*$&!!::@&!)*)*_"
      Recurly.subdomain.should == 'recurlytest3-test'
      Recurly::Base.site.to_s.should == "https://api-sandbox.recurly.com"
    end

  end
end
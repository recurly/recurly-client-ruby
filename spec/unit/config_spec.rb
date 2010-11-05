require 'spec_helper'

describe "RecurlyConfig" do

  context "loading from YML" do
    it "should load configuration from a YML file" do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test.yml")
      Recurly.username.should == "username1@recurly.com"
      Recurly.password.should == "asdf4jk31"
      Recurly.site.should == "https://site1.recurly.com"
    end
  end

  context "loading from json" do
    it "should load configuration from a json config string" do
      Recurly.configure_from_json({
        :username => "someuser@heroku.com",
        :password => "somepass",
        :site => "https://recurlytest3-test.recurly.com"
      }.to_json)
      Recurly.username.should == "someuser@heroku.com"
      Recurly.password.should == "somepass"
      Recurly.site.should == "https://recurlytest3-test.recurly.com"

      # test with some crazy chars in the password
      Recurly.configure_from_json({
        :username => "api-someuser@heroku.com",
        :password => "*$&!!::@&!)*)*_",
        :site => "https://recurlytest3-test.recurly.com"
      }.to_json)

      Recurly.username.should == "api-someuser@heroku.com"
      Recurly.password.should == "*$&!!::@&!)*)*_"
      Recurly.site.should == "https://recurlytest3-test.recurly.com"
    end

  end
end
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

  context "loading from heroku config string" do
    it "should load configuration from a config string" do
      Recurly.configure_from_heroku("someuser:somepass@https://recurlytest3-test.recurly.com")
      Recurly.username.should == "someuser"
      Recurly.password.should == "somepass"
      Recurly.site.should == "https://recurlytest3-test.recurly.com"

      # test with some crazy chars
      Recurly.configure_from_heroku("someuser:*$&!!::@&!)*)*_@https://recurlytest3-test.recurly.com")
      Recurly.username.should == "someuser"
      Recurly.password.should == "*$&!!::@&!)*)*_"
      Recurly.site.should == "https://recurlytest3-test.recurly.com"
    end

  end
end
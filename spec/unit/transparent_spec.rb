require 'spec_helper'

module Recurly
  describe Transparent do

    describe "#url" do

      it "should return the url for the configured Recurly site" do
        Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/test.yml")
        site_url = Recurly.site
        Transparent.url.should == "#{site_url}/transparent"

      end

    end


  end
end

require 'spec_helper'

module Recurly
  describe Transparent do
    # version accounts based on this current files modification dates
    timestamp = File.mtime(__FILE__).to_i

    describe ".url" do
      use_vcr_cassette "transparent/post-url/#{timestamp}"

      it "should not change after calling account.find()" do

        original_transparent_url = "#{Recurly::Base.site}/transparent/#{Recurly.subdomain}/subscription"
        Transparent.url.should == original_transparent_url
        
        account_code = "account-get-#{timestamp}"
        Factory.create_account("account-get-#{timestamp}")
        r = Account.find("account-get-#{timestamp}")

        Transparent.url.should == original_transparent_url
      
      end
    end
  end
end

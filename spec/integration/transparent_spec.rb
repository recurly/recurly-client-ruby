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
    
    it "should parse errors on nested objects" do
      response_xml = <<END
<?xml version="1.0" encoding="UTF-8"?>
<subscription>
  <id nil="true"></id>
  <account_code>2345</account_code>
<account>
  <account_code>12345</account_code>
  <username></username>
  <email>verena@test.com</email>
  <first_name>Verena</first_name>
  <last_name>Test User</last_name>
  <company_name></company_name>
  <closed type="boolean">false</closed>
  <hosted_login_token>abcd1234123412341234123412341234</hosted_login_token>
  <created_at type="datetime">2011-07-20T01:49:24Z</created_at>
  <state>active</state>
<billing_info>
  <account_code>12345</account_code>
  <first_name>Verena</first_name>
  <last_name>Test User</last_name>
  <address1></address1>
  <address2></address2>
  <city></city>
  <state></state>
  <country></country>
  <zip></zip>
  <phone></phone>
  <vat_number></vat_number>
  <ip_address>127.0.0.1</ip_address>
  <credit_card>
    <type></type>
    <last_four></last_four>
    <month type="integer">7</month>
    <year type="integer">2011</year>
  </credit_card>
  <updated_at type="datetime">2011-07-20T01:49:35Z</updated_at>
<errors>
  <error field="number">is required</error>
  <error field="verification_value">is required</error>
</errors>
</billing_info>
</account>
  <plan>
    <plan_code>gold-plan</plan_code>
    <name>Gold Plan</name>
  </plan>
  <state>pending</state>
  <quantity type="integer">1</quantity>
  <total_amount_in_cents type="integer">1200</total_amount_in_cents>
  <activated_at nil="true" type="datetime"></activated_at>
  <canceled_at nil="true" type="datetime"></canceled_at>
  <expires_at nil="true" type="datetime"></expires_at>
  <current_period_started_at type="datetime">2011-07-20T01:49:35Z</current_period_started_at>
  <current_period_ends_at type="datetime">2011-07-20T01:49:35Z</current_period_ends_at>
  <trial_started_at nil="true" type="datetime"></trial_started_at>
  <trial_ends_at nil="true" type="datetime"></trial_ends_at>
  <add_ons type="array">
  </add_ons>
</subscription>
END

      response = mock
      response.should_receive(:[]).at_least(:once).with('Content-Length').and_return '123'
      response.should_receive(:body).at_least(:once).and_return response_xml

      subscription = Subscription.new.from_transparent_results(response)
      subscription.account.billing_info.errors[:number].should_not be_nil
      subscription.account.billing_info.errors[:verification_value].should_not be_nil
    end
  end
end

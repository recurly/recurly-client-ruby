require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

require 'yaml'

require File.dirname(__FILE__) + '/../lib/recurly'


# load settings from a yml file
settings = {}
settings_path = File.dirname(__FILE__) + '/settings.yml'
if File.exists?(settings_path)
  settings = YAML.load_file(settings_path)
else
  require 'fileutils'
  # create settings.yml file
  FileUtils.cp(File.dirname(__FILE__) + '/settings.yml.example', settings_path)
  raise "Settings.yml file not found. One has been created, please edit it with your Recurly auth information"
end

# setup recurly authentication details for testing
Recurly.configure do |c|
  c.username = settings["username"]
  c.password = settings["password"]
  c.site = settings["site"]
end

TEST_PLAN_CODE = 'trial'

def create_account(account_code)
  account = Recurly::Account.create(
    :account_code => "#{Time.now.to_i}-#{account_code}",
    :first_name => 'Verena',
    :last_name => 'Test',
    :email => 'verena@test.com',
    :company_name => 'Recurly Ruby Gem')
end

def create_account_with_billing_info(account_code)

  account = create_account(account_code)

  billing_info = Recurly::BillingInfo.create(
    :account_code => account.account_code,
    :first_name => account.first_name,
    :last_name => account.last_name,
    :address1 => '123 Test St',
    :city => 'San Francisco',
    :state => 'CA',
    :zip => '94115',
    :credit_card => {
      :number => '1',
      :year => Time.now.year + 1,
      :month => Time.now.month,
      :verification_value => '123'
    }
  )

  account
end
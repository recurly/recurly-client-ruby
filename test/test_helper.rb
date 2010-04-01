require 'test/unit'
require 'rubygems'

require File.dirname(__FILE__) + '/../lib/recurly'

Recurly.configure do |c|
  c.username = ''
  c.password = ''
  c.site = ''
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
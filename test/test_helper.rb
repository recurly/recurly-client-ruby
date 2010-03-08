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
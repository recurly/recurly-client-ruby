require 'test_helper'

class AccountTest < Test::Unit::TestCase

  def test_create
    account = create_account('create')
    assert_not_nil account.created_at
  end
  
  def test_get_account
    account = create_account('get')
    
    get_acct = Recurly::Account.find(account.account_code)
    assert_not_nil get_acct
    assert_not_nil get_acct.created_at
    assert_equal account.account_code, get_acct.account_code
    assert_equal account.email, get_acct.email
    assert_equal account.first_name, get_acct.first_name
  end
  
  def test_update_account
    orig_account = create_account('update')
    
    account = Recurly::Account.find(orig_account.account_code)
    account.last_name = 'Update Test'
    account.company_name = 'Recurly Ruby Gem -- Update'
    account.save
    
    updated_acct = Recurly::Account.find(orig_account.account_code)
    assert_equal account.email, updated_acct.email
    assert_not_equal orig_account.last_name, updated_acct.last_name
    assert_not_equal orig_account.company_name, updated_acct.company_name
  end
  
  def test_close_account
    account = create_account('close')
    
    account.close_account
  end
  
end
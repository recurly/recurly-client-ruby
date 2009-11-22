require 'test_helper'

class CreditTest < Test::Unit::TestCase

  def test_credit_account
    account = create_account('credit')
     
    credit = Recurly::Credit.create(
      :account_code => account.account_code,
      :amount => 9.50
    )
    
    assert_not_nil credit.id
    assert_equal credit.amount_in_cents, -950 # Credits are negative
  end
  
  def test_list_credits
    account = create_account('credit-list')
     
    credit = Recurly::Credit.create(
      :account_code => account.account_code,
      :amount => 9.23
    )
    
    credit_list = Recurly::Credit.list(account.account_code)
    assert_not_nil credit_list
    assert_instance_of Array, credit_list
  end
  
end
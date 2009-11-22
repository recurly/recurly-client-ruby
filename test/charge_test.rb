require 'test_helper'

class ChargeTest < Test::Unit::TestCase

  def test_charge_account
    account = create_account('charge')
     
    charge = Recurly::Charge.create(
      :account_code => account.account_code,
      :amount => 9.50
    )
    
    assert_not_nil charge.id
    assert_equal charge.amount_in_cents, 950
  end
  
  def test_list_charges
    account = create_account('charge-list')
     
    charge = Recurly::Charge.create(
      :account_code => account.account_code,
      :amount => 9.23
    )
    
    charge_list = Recurly::Charge.list(account.account_code)
    assert_not_nil charge_list
    assert_instance_of Array, charge_list
  end
  
end
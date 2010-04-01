require 'test_helper'
require "test/unit"

class TransactionTest < Test::Unit::TestCase

  def test_create_transaction
    account = create_account_with_billing_info('transaction')
    
    trans = Recurly::Transaction.create(
      :account => { :account_code => account.account_code },
      :amount_in_cents => 500, 
      :description => "test transaction for $5"
    )
    
    assert_not_nil trans.id
    assert_equal trans.amount_in_cents, 500
  end
  
end

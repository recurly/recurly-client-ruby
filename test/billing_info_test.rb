require 'test_helper'

class BillingInfoTest < Test::Unit::TestCase

  def test_update_billing_info
    account = create_account('billing')
    
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
    
    assert_instance_of Recurly::BillingInfo, billing_info
    assert_not_nil billing_info.updated_at
  end

end
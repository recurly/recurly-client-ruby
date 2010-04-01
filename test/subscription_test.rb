require 'test_helper'
require "test/unit"

class SubscriptionTest < Test::Unit::TestCase

  def test_create_subscription_new_account
    account = Recurly::Account.new(
      :account_code => "#{Time.now.to_i}-new-sub-new-account",
      :first_name => 'Verena',
      :last_name => 'Test',
      :email => 'verena@test.com',
      :company_name => 'Recurly Ruby Gem')
      
    sub = create_subscription(account)
    assert_not_nil sub
    assert_nil sub.canceled_at
    assert_equal sub.state, 'active'
    assert_not_nil sub.current_period_started_at
  end
  
  def test_create_subscription_existing_account
    account = create_account('existing-account')
    sub = create_subscription(account)
    
    assert_equal sub.state, 'active'
  end
  
  def test_update_subscription
    account = create_account('update-subscription')
    sub = create_subscription(account)
    
    sub.change('now', :quantity => 2)
    
    sub = Recurly::Subscription.find(account.account_code)
    assert_equal sub.quantity, 2
  end
  
  def test_cancel_subscription
    account = create_account('cancel-subscription')
    subscription = create_subscription(account)
    
    subscription.cancel(account.account_code)
    
    sub = Recurly::Subscription.find(account.account_code)
    assert_equal sub.state, 'canceled'
    assert_not_nil sub.canceled_at
  end 
  
  def test_refund_subscription
    account = create_account('refund-subscription')
    subscription = create_subscription(account)
    
    subscription.refund(:full)
    
    assert_raises ActiveResource::ResourceNotFound do
      get_sub = Recurly::Subscription.find(account.account_code)
    end
  end
  
  def create_subscription(account, subscription_attrs={})
    account.billing_info = Recurly::BillingInfo.new(
      :first_name => account.first_name,
      :last_name => account.last_name,
      :address1 => '123 Test St',
      :city => 'San Francisco',
      :state => 'CA',
      :country => 'US',
      :zip => '94103',
      :credit_card => {
        :number => '1',
        :year => Time.now.year + 1,
        :month => Time.now.month,
        :verification_value => '123'
      },
      :ip_address => '127.0.0.1'
    )
    
    params = {:account_code => account.account_code,
              :plan_code => TEST_PLAN_CODE, 
              :quantity => 1,
              :account => account}.merge subscription_attrs
    
    sub = Recurly::Subscription.create(params)
    
  end

end
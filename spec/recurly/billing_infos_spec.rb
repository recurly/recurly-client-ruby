require 'spec_helper'

describe BillingInfos do
  before do
    stub_api_request :get, 'accounts/abcdef1234567890/billing_infos', 'billing_infos/create-201'

    stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/create-201'
    stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'

    stub_api_request :get, 'accounts/abcdef1234567890/billing_infos/billinginfo1', 'billing_infos/show-200'
  end

  it 'should allow fetching billing info by uuid' do
    account = Account.find('abcdef1234567890')

    billing_info = account.get_billing_info('billinginfo1')

    billing_info.primary_payment_method.must_equal true
    billing_info.backup_payment_method.must_equal false
    billing_info.first_name.must_equal 'Shinji'
    billing_info.last_name.must_equal 'Ikari'
  end

  it 'should show multiple payment methods on an account' do
    stub_api_request :get, 'accounts/abcdef1234567890/billing_infos', 'billing_infos/index-200'
    stub_api_request(:head, 'accounts/abcdef1234567890/billing_infos') { XML[200][:head] }
    account = Account.find('abcdef1234567890')

    billing_infos = account.get_billing_infos

    billing_infos.length.must_equal 2
  end

  it 'should allow updating an existing payment method' do

  end

  it 'should show a single billing info specified' do

  end
end

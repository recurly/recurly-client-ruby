require 'spec_helper'

describe BillingInfo do
  before do
    stub_api_request :post, 'accounts/abcdef1234567890/billing_infos', 'billing_infos/create-201'
    stub_api_request :get, 'accounts/abcdef1234567890/billing_infos', 'billing_infos/index-200'
    stub_api_request :get, 'accounts/abcdef1234567890/billing_infos/billinginfo1', 'billing_infos/show-200'

    stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
  end

  it 'should allow creating a billing info' do
    account = Account.find('abcdef1234567890')

    new_billing_info = BillingInfo.new
    billing_info = account.create_billing_info(new_billing_info)

    billing_info.primary_payment_method.must_equal false
    billing_info.backup_payment_method.must_equal true
    billing_info.first_name.must_equal 'Asuka'
    billing_info.last_name.must_equal 'Soryu'
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
    account = Account.find('abcdef1234567890')

    billing_infos = account.get_billing_infos

    billing_infos.length.must_equal 2

    billing_infos[0].first_name.must_equal 'Shinji'
    billing_infos[0].last_name.must_equal 'Ikari'
    billing_infos[1].first_name.must_equal 'Asuka'
    billing_infos[1].last_name.must_equal 'Soryu'
  end

  it 'should allow updating an existing payment method' do
    account = Account.find('abcdef1234567890')

    billing_info_uuid = account.get_billing_infos.first.uuid

    stub_api_request :put, "accounts/abcdef1234567890/billing_infos/#{billing_info_uuid}", 'billing_infos/show-200-updated'

    billing_info = account.get_billing_info(billing_info_uuid)
    billing_info.update_attributes(
      first_name: 'Gendo'
    )

    billing_info.first_name.must_equal 'Gendo'
    billing_info.last_name.must_equal 'Ikari'
  end
end

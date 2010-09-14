module Recurly
  module Factory
    def self.create_account(account_code)
      account = Account.create(
        :account_code => "#{Time.now.to_i}-#{account_code}",
        :first_name => 'Verena',
        :last_name => 'Test',
        :email => 'verena@test.com',
        :company_name => 'Recurly Ruby Gem')
    end

    def self.create_account_with_billing_info(account_code)

      account = Factory.create_account(account_code)

      billing_info = BillingInfo.create(
        :account_code => account.account_code,
        :first_name => account.first_name,
        :last_name => account.last_name,
        :address1 => '123 Test St',
        :city => 'San Francisco',
        :state => 'CA',
        :zip => '94115',
        :country => "US",
        :credit_card => {
          :number => '1',
          :year => Time.now.year + 1,
          :month => Time.now.month,
          :verification_value => '123'
        }
      )

      account
    end

    def self.create_subscription(account, subscription_attrs={})
      account.billing_info = BillingInfo.new(
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

      sub = Subscription.create(params)

    end
  end
end
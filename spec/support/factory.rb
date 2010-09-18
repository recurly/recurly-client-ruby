module Recurly
  module Factory
    def self.create_account(account_code)
      account = Account.create(
        :account_code => "#{account_code}",
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

    def self.create_subscription(account, plan, subscription_attrs={})
      if plan.is_a?(Symbol)
        plan = self.send("#{plan}_plan")
      end

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
                :plan_code => plan || regular_plan,
                :quantity => 1,
                :account => account}.merge subscription_attrs

      sub = Subscription.create(params)
    end

    def self.trial_plan
      find_or_create_plan({
        :plan_code => "trial",
        :name => "Trial",

        # 10 dollars a month
        :unit_amount_in_cents => 1000,

        # 1 year intervals
        :plan_interval_length => 1,
        :plan_interval_unit => "years",

        # 1 month trial
        :trial_interval_length => 1,
        :trial_interval_unit => "months"
      })
    end

    def self.regular_plan
      find_or_create_plan({
        :plan_code => "regular",
        :name => "Regular",

        # 10 dollars a month
        :unit_amount_in_cents => 1000,

        # 1 month intervals
        :plan_interval_length => 1,
        :plan_interval_unit => "months",

        # 0 trial
        :trial_interval_length => 0,
        :trial_interval_unit => "months"
      })
    end

    def self.find_or_create_plan(data)
      begin
        plan = Plan.find(data[:plan_code])

        if plan.unit_amount_in_cents != data[:unit_amount_in_cents]
          plan.unit_amount_in_cents = data[:unit_amount_in_cents]
          plan.save!
        end

        return plan
      rescue ActiveResource::ResourceNotFound => e
        plan = Plan.new(data)
        plan.save!
        return plan
      end
    end
  end
end
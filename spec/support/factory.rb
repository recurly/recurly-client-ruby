module Recurly
  module Factory

    # creates an account
    def self.create_account(account_code)
      account = Account.new :account_code => "#{account_code}",
                            :first_name => 'Verena',
                            :last_name => 'Test',
                            :email => 'verena@test.com',
                            :company_name => 'Recurly Ruby Gem'
      account.save!
      account
    end

    # creates an account with associated billing information
    def self.create_account_with_billing_info(account_code)
      account = Factory.create_account(account_code)
      billing_info = build_billing_info(account)
      billing_info.save!
      account
    end

    # Creates a subscription for an account
    def self.create_subscription(account, plan, subscription_attrs={})
      if plan.is_a?(Symbol)
        plan = self.send("#{plan}_plan")
      end

      # default to paid plan if none specified
      plan ||= paid_plan

      account.billing_info = build_billing_info(account)
      params = {:account_code => account.account_code,
                :plan_code => (plan || paid_plan).plan_code,
                :quantity => 1,
                :account => account}.merge subscription_attrs

      subscription = Subscription.new(params)
      subscription.save!
      return subscription
    end

    def self.build_billing_info(account)
      billing_info = BillingInfo.new(
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

      return billing_info
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

    def self.paid_plan
      find_or_create_plan({
        :plan_code => "paid",
        :name => "Paid",

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
        return Plan.find(data[:plan_code])
      rescue ActiveResource::ResourceNotFound => e
        plan = Plan.new(data)
        plan.save!
        return plan
      end
    end
  end
end
module Recurly
  module Factory


    # creates an account
    def self.create_account(account_code, overrides = {})
      account = Account.new(account_attributes(account_code, overrides))
      account.save!
      account
    end

    def self.account_attributes(account_code, overrides = {})
      attributes = {
        # version is used to avoid duplicate account errors on recurly's api, pass in a different one every time
        :account_code => account_code,
        :first_name => 'Verena',
        :last_name => 'Test',
        :email => 'verena@test.com',
        :company_name => 'Recurly Ruby Gem'
      }

      # add overrides
      overrides.each do |key, val|
        attributes[key] = val
      end

      attributes
    end

    # creates an account with associated billing information
    def self.create_account_with_billing_info(account_code, address_overrides = {}, credit_card_overrides = {})
      account = Factory.create_account(account_code)

      # create billing info
      billing_info = BillingInfo.new(billing_attributes(address_overrides, credit_card_overrides))
      billing_info.account_code = account_code
      billing_info.first_name = account.first_name unless billing_info.respond_to?(:first_name)
      billing_info.last_name = account.last_name unless billing_info.respond_to?(:last_name)
      billing_info.save!

      # return account
      account
    end

    # returns a hash of billing information
    def self.billing_attributes(address_overrides = {}, credit_card_overrides = {})
      attributes = {
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
      }

      # overrides for address
      address_overrides.each do |key, val|
        attributes[key] = val
      end

      # overrides for credit cards
      credit_card_overrides.each do |key, val|
        attributes[:credit_card][key] = val
      end

      attributes
    end

    # Creates a subscription for an account
    def self.create_subscription(account, plan, overrides={})
      plan = self.send("#{plan}_plan") if plan.is_a?(Symbol)

      # default to paid plan if none specified
      plan ||= paid_plan

      account.billing_info = BillingInfo.new(billing_attributes)

      # set account information
      account.billing_info.first_name = account.first_name
      account.billing_info.last_name = account.last_name

      attributes = {
        :account_code => account.account_code,
        :plan_code => (plan || paid_plan).plan_code,
        :quantity => 1,
        :account => account
      }

      overrides.each do |key,val|
        attributes[key] = val
      end

      subscription = Subscription.new(attributes)
      subscription.save!
      return subscription
    end

    def self.create_charge(account_code, attributes = {})
      charge = Charge.new({
        :account_code => account_code,
        :amount => 10.00,
        :description => "charge description"
      }.merge(attributes))
      charge.save!
      charge
    end

    def self.create_transaction(account_code, overrides = {})
      attributes = {
        :account => {
          :account_code => account_code
        }
      }

      overrides.each do |key, val|
        attributes[key] = val
      end

      transaction = Transaction.new(attributes)
      transaction.save!

      transaction
    end

    # creates a full transaction from scratch
    def self.create_full_transaction(account_code, overrides = {}, address_overrides = {}, credit_card_overrides = {})
      attributes = {
        :account => {
          :account_code => account_code,
          :first_name => 'Verena',
          :last_name => 'Test',
          :email => 'verena@test.com',
          :company_name => 'Recurly Ruby Gem',
          :billing_info => billing_attributes(address_overrides, credit_card_overrides)
        }
      }

      overrides.each do |key, val|
        attributes[key] = val
      end

      transaction = Transaction.new(attributes)
      transaction.save!

      transaction
    end

    def self.create_credit(account_code, attributes = {})
      credit = Credit.new({
        :account_code => account_code,
        :amount => 10.00,
        :description => "free moniez"
      }.merge(attributes))
      credit.save!
      credit
    end

    def self.trial_plan
      find_or_create_plan({
        :plan_code => "trial",
        :name => "Trial",

        # 10 dollars a month
        :unit_amount_in_cents => 1000,

        # 1 month intervals
        :plan_interval_length => 1,
        :plan_interval_unit => "months",

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
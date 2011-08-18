module Recurly
  class Subscription < AccountBase
    self.element_name = "subscription"

    def self.known_attributes
      [
        "plan_code",
        "coupon_code",
        "unit_amount_in_cents",
        "quantity",
        "trial_ends_at"
      ]
    end

    # initialize associations
    def initialize(attributes = {}, persisted = false)
      attributes = attributes.with_indifferent_access
      attributes[:account] ||= {}
      attributes[:addons] ||= []
      super(attributes, persisted)
    end

    def self.refund(account_code, refund_type = :partial)
      raise "Refund type must be :full, :partial, or :none." unless [:full, :partial, :none].include?(refund_type)
      Subscription.delete(nil, {:account_code => account_code, :refund => refund_type})
    end

    # Terminates the subscription immediately and processes a full or partial refund
    def refund(refund_type)
      self.class.refund(self.subscription_account_code, refund_type)
    end

    def self.cancel(account_code)
      Subscription.delete(account_code)
    end

    # Stops the subscription from renewing. The subscription remains valid until the end of
    # the current term (current_period_ends_at).
    def cancel(account_code = nil)
      unless account_code.nil?
        ActiveSupport::Deprecation.warn('Calling Recurly::Subscription#cancel with an account_code has been deprecated. Use the static method Recurly::Subscription.cancel(account_code) instead', caller)
      end
      self.class.cancel(account_code || self.subscription_account_code)
    end

    def self.reactivate(account_code, options = {})
      path = "/accounts/#{CGI::escape(account_code.to_s)}/subscription/reactivate"
      connection.post(path, "", headers)
    rescue ActiveResource::Redirection => e
      return true
    end

    def reactivate
      self.class.reactivate(self.subscription_account_code)
    end

    # Valid timeframe: :now or :renewal
    # Valid options: plan_code, quantity, unit_amount
    def change(timeframe, options = {})
      raise "Timeframe must be :now or :renewal." unless ['now','renewal'].include?(timeframe)
      options[:timeframe] = timeframe
      path = "/accounts/#{CGI::escape(self.subscription_account_code.to_s)}/subscription.xml"
      connection.put(path,
        self.class.format.encode(options, :root => :subscription),
        self.class.headers)
    rescue ActiveResource::ResourceInvalid => e
      self.load_errors e.response.body
    end

    def subscription_account_code
      acct_code = self.account_code if defined?(self.account_code) and !self.account_code.nil? and !self.account_code.blank?
      acct_code ||= account.account_code if defined?(account) and !account.nil?
      acct_code ||= self.primary_key if defined?(self.primary_key)
      acct_code ||= self.id if defined?(self.id)
      raise 'Missing Account Code' if acct_code.blank?
      acct_code
    end
  end
end


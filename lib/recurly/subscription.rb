module Recurly
  class Subscription < Resource
    autoload :AddOns, 'recurly/subscription/add_ons'

    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Subscription>] A pager that yields +$1+ subscriptions.
    scope :active,   :state => :active
    scope :canceled, :state => :canceled
    scope :expired,  :state => :expired
    scope :future,   :state => :future
    # @return [Pager<Subscription>] A pager that yields subscriptions in
    #   trials.
    scope :in_trial, :state => :in_trial
    # @return [Pager<Subscription>] A pager that yields active, canceled, and
    #   future subscriptions.
    scope :live,     :state => :live
    scope :past_due, :state => :past_due

    # @return [Account]
    belongs_to :account
    # @return [Plan]
    belongs_to :plan

    # @return [Invoice]
    has_one :invoice

    define_attribute_methods %w(
      uuid
      state
      unit_amount_in_cents
      currency
      quantity
      activated_at
      canceled_at
      expires_at
      current_period_started_at
      current_period_ends_at
      trial_started_at
      trial_ends_at
      pending_subscription
      subscription_add_ons
      coupon_code
      total_billing_cycles
      net_terms
      collection_method
      po_number
      tax_in_cents
      tax_type
    )
    alias to_param uuid

    # @return [Subscription] A new subscription.
    def initialize attributes = {}
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    # Assign a Plan resource (rather than a plan code).
    #
    # @param plan [Plan]
    def plan= plan
      self.plan_code = (plan.plan_code if plan.respond_to? :plan_code)
      attributes[:plan] = plan
    end

    def plan_code
      self[:plan_code] ||= (plan.plan_code if plan.respond_to? :plan_code)
    end

    def plan_code= plan_code
      self[:plan_code] = plan_code
    end

    # Assign a Coupon resource (rather than a coupon code).
    #
    # @param coupon [Coupon]
    def coupon= coupon
      self.coupon_code = (
        coupon.coupon_code if coupon.respond_to? :coupon_code
      )
      attributes[:coupon] = coupon
    end

    # @return [AddOns]
    def subscription_add_ons
      self[:subscription_add_ons] ||= AddOns.new self, super
    end
    alias add_ons subscription_add_ons

    # Assign an array of subscription add-ons.
    def subscription_add_ons= subscription_add_ons
      super AddOns.new self, subscription_add_ons
    end
    alias add_ons= subscription_add_ons=

    # Cancel a subscription so that it will not renew.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the subscription is not active).
    # @example
    #   account = Account.find account_code
    #   subscription = account.subscriptions.first
    #   subscription.cancel # => true
    def cancel
      return false unless link? :cancel
      reload follow_link :cancel
      true
    end

    # An array of acceptable refund types.
    REFUND_TYPES = ['none', 'full', 'partial'].freeze

    # Immediately terminate a subscription (with optional refund).
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the subscription is not active).
    # @param refund_type [:none, :full, :partial] <tt>:none</tt> terminates the
    #   subscription with no refund (the default), <tt>:full</tt> refunds the
    #   subscription in full, and <tt>:partial</tt> refunds the subscription in
    #   part.
    # @raise [ArgumentError] Invalid +refund_type+.
    # @example
    #   account = Account.find account_code
    #   subscription = account.subscriptions.first
    #   subscription.terminate(:partial) # => true
    def terminate refund_type = :none
      return false unless link? :terminate
      unless REFUND_TYPES.include? refund_type.to_s
        raise ArgumentError, "refund must be one of: #{REFUND_TYPES.join ', '}"
      end
      reload follow_link(:terminate, :params => { :refund => refund_type })
      true
    end
    alias destroy terminate

    # Reactivate a subscription.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the subscription is already active), and may raise an exception
    #   if the reactivation fails.
    def reactivate
      return false unless link? :reactivate
      reload follow_link :reactivate
      true
    end

    # Postpone a subscription's renewal date.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the subscription is not active).
    # @param next_renewal_date [Time] when the subscription should renew.
    def postpone next_renewal_date
      return false unless link? :postpone
      reload follow_link(:postpone,
        :params => { :next_renewal_date => next_renewal_date }
      )
      true
    end

    def signable_attributes
      super.merge :plan_code => plan_code
    end
  end
end

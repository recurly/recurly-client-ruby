module Recurly
  class Account < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Account>] A pager that yields +$1+ accounts.
    scope :active,         :state => :active
    scope :closed,         :state => :closed
    scope :subscriber,     :state => :subscriber
    scope :non_subscriber, :state => :non_subscriber
    scope :past_due,       :state => :past_due

    # @macro [attach] has_many
    #   @return [Pager<Resource>, []] A pager that yields $1 for persisted
    #     accounts; an empty array otherwise.
    has_many :adjustments
    has_many :invoices
    has_many :subscriptions
    has_many :transactions
    has_many :redemptions
    has_many :shipping_addresses, resource_class: :ShippingAddress, readonly: false

    # @return [BillingInfo, nil]
    has_one :billing_info, :readonly => false

    # @return [AccountBalance, nil]
    has_one :account_balance, :readonly => true

    def redemption coupon_code
      redemptions.detect { |r| r.coupon_code == coupon_code }
    end

    define_attribute_methods %w(
      account_code
      state
      username
      email
      cc_emails
      first_name
      last_name
      company_name
      accept_language
      hosted_login_token
      vat_number
      address
      tax_exempt
      entity_use_code
      created_at
      updated_at
      closed_at
      vat_location_valid
      has_live_subscription
      has_active_subscription
      has_future_subscription
      has_canceled_subscription
      has_past_due_invoice
    )
    alias to_param account_code

    # @return [Invoice] A newly-created invoice.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def invoice!(attrs={})
      Invoice.from_response API.post(invoices.uri, attrs.empty? ? nil : Invoice.to_xml(attrs))
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # @return [Invoice] The newly-built invoice that has not been persisted.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def build_invoice
      Invoice.from_response API.post("#{invoices.uri}/preview")
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Reopen an account.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the account is already opwn), and may raise an exception if the
    #   attempt fails.
    def reopen
      return false unless link? :reopen
      reload follow_link :reopen
      true
    end

    def changed_attributes
      attrs = super
      if address.respond_to?(:changed?) && address.changed?
        attrs['address'] = address
      end
      attrs
    end

    private

    def xml_keys
      keys = super
      keys << 'account_code' if account_code? && !account_code_changed?
      keys.sort
    end
  end
end

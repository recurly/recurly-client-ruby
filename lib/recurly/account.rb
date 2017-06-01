module Recurly
  # Accounts are core to managing your customers inside of Recurly.
  # The account object stores the entire Recurly history of your customer and acts as the entry point
  # for working with a customer's billing information, subscription data, transactions, invoices and more.
  #
  # Recurly Documentation: https://dev.recurly.com/docs/account-object
  class Account < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Account>] A pager that yields +$1+ accounts.
    scope :active,         state: :active
    scope :closed,         state: :closed
    scope :subscriber,     state: :subscriber
    scope :non_subscriber, state: :non_subscriber
    scope :past_due,       state: :past_due

    # @return [Pager<Adjustment>, []] A pager that yields Adjustments for persisted
    has_many :adjustments

    # @return [Pager<Invoice>, []] A pager that yields Invoices for persisted
    has_many :invoices

    # @return [Pager<Subscription>, []] A pager that yields Subscriptions for persisted
    has_many :subscriptions

    # @return [Pager<Transaction>, []] A pager that yields Transaction for persisted
    has_many :transactions

    # @return [Pager<Redemption>, []] A pager that yields Redemptions for persisted
    has_many :redemptions

    # @return [Pager<ShippingAddress>, [ShippingAddress], []] A pager that yields ShippingAddresses;
    #   or a list of ShippingAddresses if set by the programmer
    has_many :shipping_addresses, readonly: false

    # @return [BillingInfo, nil]
    has_one :billing_info, readonly: false

    # @return [AccountBalance, nil]
    has_one :account_balance, readonly: true

    # Get's the first redemption given a coupon code
    # @deprecated Use #{redemptions} instead
    # @param coupon_code [String] The coupon code for the redemption
    def redemption(coupon_code)
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

    # Creates an invoice from the pending charges on the account.
    # Raises an error if it fails.
    #
    # @return [Invoice] A newly-created invoice.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def invoice!(attrs={})
      Invoice.from_response API.post(invoices.uri, attrs.empty? ? nil : Invoice.to_xml(attrs))
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Builds an invoice from the pending charges on the account but does not persist the invoice.
    # Raises an error if it fails.
    #
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

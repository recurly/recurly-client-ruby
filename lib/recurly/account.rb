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

    # @return [Pager<Note>, []] A pager that yields Note for persisted
    has_many :notes

    # @return [Pager<Redemption>, []] A pager that yields Redemptions for persisted
    has_many :redemptions

    # @return [Pager<ShippingAddress>, [ShippingAddress], []] A pager that yields ShippingAddresses;
    #   or a list of ShippingAddresses if set by the programmer
    has_many :shipping_addresses, readonly: false

    # @return [BillingInfo, nil]
    has_one :billing_info, readonly: false

    # @return [AccountBalance, nil]
    has_one :account_balance, readonly: true

    # @return [Account, nil]
    belongs_to :parent_account, class_name: :Account

    # @return [Pager<Account>, []] A pager that yields Account for persisted
    has_many :child_accounts, class_name: :Account

    # @return [Pager<CreditPayment>, []]
    has_many :credit_payments, class_name: :CreditPayment, readonly: true

    # @return [[CustomField], []]
    has_many :custom_fields, class_name: :CustomField, readonly: false

    # @return [AccountAcquisition, nil]
    has_one :account_acquisition, class_name: :AccountAcquisition, readonly: false

    # @return [InvoiceTemplate, nil]
    belongs_to :invoice_template, class_name: :InvoiceTemplate, readonly: true

    # Get's the first redemption given a coupon code
    # @deprecated Use #{redemptions} instead
    # @param coupon_code [String] The coupon code for the redemption
    def redemption(coupon_code)
      redemptions.detect { |r| r.coupon_code == coupon_code }
    end

    define_attribute_methods %w(
      account_code
      parent_account_code
      state
      username
      email
      cc_emails
      first_name
      last_name
      company_name
      company
      phone
      accept_language
      hosted_login_token
      vat_number
      address
      tax_exempt
      exemption_certificate
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
      has_paused_subscription
      preferred_locale
      transaction_type
      dunning_campaign_id
      invoice_template_uuid
    )
    alias to_param account_code

    def company_name
      super || company
    end

    # Creates an invoice from the pending charges on the account.
    # Raises an error if it fails.
    #
    # @return [InvoiceCollection] A newly-created invoice.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def invoice!(attrs={})
      InvoiceCollection.from_response API.post(invoices.uri, attrs.empty? ? nil : Invoice.to_xml(attrs))
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Builds an invoice from the pending charges on the account but does not persist the invoice.
    # Raises an error if it fails.
    #
    # @return [InvoiceCollection] The newly-built invoice that has not been persisted.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def build_invoice
      InvoiceCollection.from_response API.post("#{invoices.uri}/preview")
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    def create_billing_info(billing_info)
      billing_info = billing_info
      billing_info.uri = "#{path}/billing_infos"
      billing_info.save!
      billing_info
    end

    def get_billing_infos
      Pager.new(Recurly::BillingInfo, uri: "#{path}/billing_infos", parent: self)
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    def get_billing_info(billing_info_uuid)
      BillingInfo.from_response API.get("#{path}/billing_infos/#{billing_info_uuid}")
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Reopen an account.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the account is already open), and may raise an exception if the
    #   attempt fails.
    def reopen
      return false unless link? :reopen
      reload follow_link :reopen
      true
    end

    # Verify a cvv code for the account's billing info.
    #
    # @example
    #   acct = Recurly::Account.find('benjamin-du-monde')
    #   begin
    #     # If successful, returned billing_info will contain
    #     # updated billing info details.
    #     billing_info = acct.verify_cvv!("504")
    #   rescue Recurly::API::BadRequest => e
    #     e.message # => "This credit card has too many cvv check attempts."
    #   rescue Recurly::Transaction::Error => e
    #     # this will be the errors coming back from gateway
    #     e.transaction_error_code # => "fraud_security_code"
    #     e.gateway_error_code # => "fraud"
    #   rescue Recurly::Resource::Invalid => e
    #     e.message # => "verification_value must be three digits"
    #   end
    #
    # @param [String] verification_value The CVV code to check
    # @return [BillingInfo] The updated billing info
    # @raise [Recurly::Transaction::Error] A Transaction Error will be raised if the gateway declines
    # the cvv code.
    # @raise [API::BadRequest] A BadRequest error will be raised if you attempt to check too many times
    # and are locked out.
    # @raise [Resource::Invalid] An Invalid Error will be raised if you send an invalid request (such as
    # a value that is not a propert verification number).
    def verify_cvv!(verification_value)
      bi = BillingInfo.new(verification_value: verification_value)
      bi.uri = "#{path}/billing_info/verify_cvv"
      bi.save!
      bi
    end

    def changed_attributes
      attrs = super
      if address.respond_to?(:changed?) && address.changed?
        attrs['address'] = address
      end
      if custom_fields.any?(&:changed?)
        attrs['custom_fields'] = custom_fields.select(&:changed?)
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

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

    # @return [BillingInfo, nil]
    has_one :billing_info, :readonly => false

    # @return [Redemption, nil]
    has_one :redemption

    define_attribute_methods %w(
      account_code
      state
      username
      email
      first_name
      last_name
      company_name
      accept_language
      hosted_login_token
      vat_number
      address
      tax_exempt
      created_at
    )
    alias to_param account_code

    # @return [Invoice] A newly-created invoice.
    # @raise [Invalid] Raised if the account cannot be invoiced.
    def invoice!
      Invoice.from_response API.post(invoices.uri)
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

    private

    def xml_keys
      keys = super
      keys << 'account_code' if account_code? && !account_code_changed?
      keys.sort
    end
  end
end

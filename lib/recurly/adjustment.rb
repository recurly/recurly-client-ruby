module Recurly
  class Adjustment < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Adjustment>] a pager that yields +$1+.
    scope :charges,  :type  => 'charge'
    scope :credits,  :type  => 'credit'

    scope :pending,  :state => 'pending'
    scope :invoiced, :state => 'invoiced'

    # @return [Account, nil]
    belongs_to :account
    # @return [Invoice, nil]
    belongs_to :invoice
    # @return [Subscription, nil]
    belongs_to :subscription

    define_attribute_methods %w(
      uuid
      state
      description
      accounting_code
      origin
      unit_amount_in_cents
      quantity
      discount_in_cents
      tax_in_cents
      total_in_cents
      currency
      tax_exempt
      product_code
      start_date
      end_date
      created_at
    )
    alias to_param uuid

    # @return ["charge", "credit", nil] The type of adjustment.
    attr_reader :type

    # Adjustments should be built through {Account} instances.
    #
    # @return [Adjustment] A new adjustment.
    # @example
    #   account.adjustments.new attributes
    # @see Resource#initialize
    def initialize attributes = {}
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    # Adjustments are only writeable through an {Account} instance.
    embedded! true
  end
end

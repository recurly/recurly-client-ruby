module Recurly
  # The history of your customer's Recurly account can be tracked through adjustments, made up of credits and charges.
  #
  # Recurly Documentation: https://dev.recurly.com/docs/adjustment-object
  class Adjustment < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Adjustment>] a pager that yields +$1+.
    scope :charges,  type:  'charge'
    scope :credits,  type:  'credit'
    scope :pending,  state: 'pending'
    scope :invoiced, state: 'invoiced'

    # @return [Account, nil]
    belongs_to :account
    # @return [Invoice, nil]
    belongs_to :invoice
    # @return [Subscription, nil]
    belongs_to :subscription

    # @return [Pager<Adjustment>, []]
    has_many :credit_adjustments, class_name: :Adjustment, readonly: true

    # @return [ShippingAddress, nil]
    has_one :shipping_address, class_name: :ShippingAddress, readonly: false

    define_attribute_methods %w(
      uuid
      state
      description
      accounting_code
      origin
      unit_amount_in_cents
      quantity
      discount_in_cents
      total_in_cents
      currency
      product_code
      start_date
      end_date
      created_at
      updated_at
      quantity_remaining
      revenue_schedule_type
      tax_in_cents
      tax_type
      tax_region
      tax_rate
      tax_exempt
      tax_code
      tax_details
      tax_types
      proration_rate
      credit_reason_code
      original_adjustment_uuid
      shipping_address_id
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
    def initialize(attributes = {})
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    # Adjustments are only writeable through an {Account} instance.
    embedded! true
  end
end

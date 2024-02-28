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
    # @return [Account, nil]
    belongs_to :bill_for_account, class_name: :Account, readonly: true
    # @return [Invoice, nil]
    belongs_to :invoice
    # @return [Subscription, nil]
    belongs_to :subscription

    # @return [Pager<Adjustment>, []]
    has_many :credit_adjustments, class_name: :Adjustment, readonly: true

    # @return [ShippingAddress, nil]
    has_one :shipping_address, class_name: :ShippingAddress, readonly: false

    # @return [[CustomField], []]
    has_many :custom_fields, class_name: :CustomField, readonly: false

    define_attribute_methods %w[
      uuid
      state
      description
      accounting_code
      origin
      unit_amount_in_cents
      quantity
      quantity_decimal
      discount_in_cents
      total_in_cents
      currency
      product_code
      item_code
      external_sku
      start_date
      end_date
      created_at
      updated_at
      quantity_remaining
      quantity_decimal_remaining
      revenue_schedule_type
      tax_in_cents
      tax_type
      tax_region
      tax_rate
      tax_exempt
      tax_inclusive
      tax_code
      tax_details
      tax_types
      proration_rate
      credit_reason_code
      original_adjustment_uuid
      shipping_address_id
      surcharge_in_cents
      avalara_transaction_type
      avalara_service_type
      refundable_total_in_cents
    ] + RevRec::ALL_ATTRIBUTES
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

    def changed_attributes
      attrs = super
      if custom_fields.any?(&:changed?)
        attrs['custom_fields'] = custom_fields.select(&:changed?)
      end
      attrs
    end

    # Adjustments are only writeable through an {Account} instance.
    embedded! true
  end
end

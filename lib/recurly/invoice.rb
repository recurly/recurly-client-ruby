module Recurly
  # Invoices are created through account objects.
  #
  # Recurly Documentation: https://dev.recurly.com/docs/list-invoices
  #
  # @example
  #   account = Account.find(account_code)
  #   account.invoice!
  class Invoice < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Invoice>] A pager that yields +$1+ invoices.
    scope :pending,   :state => :pending
    scope :paid,      :state => :paid
    scope :failed,    :state => :failed
    scope :past_due,  :state => :past_due

    # These are deprecated as the states were renamed
    scope :open,      :state => :pending
    scope :collected, :state => :paid

    # @return [Account]
    belongs_to :account

    # @return [Pager<Subscription>, []]
    has_many :subscriptions

    # This will only be present if the invoice has > 500 line items
    # @return [Pager<Adjustment>, []]
    has_many :all_line_items, class_name: :Adjustment

    # This will only be present if the invoice has > 500 transactions
    # @return [Pager<Transaction>, []]
    has_many :all_transactions, class_name: :Transaction

    # @return [Pager<Redemption>, []]
    has_many :redemptions

    # @return [ShippingAddress, nil]
    has_one :shipping_address, class_name: :ShippingAddress, readonly: true

    # @return [Pager<Invoice>, []]
    has_many :credit_invoices, class_name: :Invoice

    # @return [[CreditPayment]]
    has_many :credit_payments, class_name: :CreditPayment, readonly: true

    # @return [Pager<Invoice>, []]
    has_many :original_invoices, class_name: :Invoice, readonly: true

    # @return [Invoice, nil]
    has_one :original_invoice, class_name: :Invoice, readonly: true

    # Returns the first redemption in the Invoice's redemptions.
    # This was placed here for backwards compatibility when we went from
    # having a single redemption per invoice to multiple redemptions per invoice.
    #
    # @deprecated Use {#redemptions} and find the redemption you want.
    def redemption
      redemptions.first
    end

    # @return [String] The invoice number with the prefix (if there is one)
    def invoice_number_with_prefix
      "#{invoice_number_prefix}#{invoice_number}"
    end

    define_attribute_methods %w(
      uuid
      state
      invoice_number
      invoice_number_prefix
      po_number
      vat_number
      subtotal_in_cents
      tax_in_cents
      tax_type
      tax_region
      tax_rate
      total_in_cents
      currency
      created_at
      updated_at
      closed_at
      amount_remaining_in_cents
      line_items
      transactions
      terms_and_conditions
      vat_reverse_charge_notes # Only shows if reverse charge invoice
      customer_notes
      address
      net_terms
      collection_method
      tax_types
      refund_tax_date
      refund_geo_code
      subtotal_before_discount_in_cents
      attempt_next_collection_at
      recovery_reason
      discount_in_cents
      balance_in_cents
      due_on
      type
      origin
      credit_customer_notes
      refund_method
    )
    alias to_param invoice_number_with_prefix

    def self.to_xml(attrs)
      invoice = new attrs
      invoice.to_xml
    end

    # Marks an invoice as paid successfully.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def mark_successful
      return false unless link? :mark_successful
      reload follow_link :mark_successful
      true
    end

    # Marks an invoice as failing collection.
    # Returns a new {InvoiceCollection} and does not
    # reload this invoice.
    #
    # @return [InvoiceCollection, false] InvoiceCollection when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def mark_failed
      return false unless link? :mark_failed
      InvoiceCollection.from_response follow_link(:mark_failed)
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Initiate a collection attempt on an invoice.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def force_collect
      return false unless link? :force_collect
      reload follow_link :force_collect
      true
    end

    # Voids the invoice.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def void
      return false unless link? :void
      reload follow_link :void
      true
    end

    # Posts an offline payment on this invoice
    #
    # @return [Transaction]
    # @raise [Error] If the transaction fails.
    def enter_offline_payment(attrs={})
      Transaction.from_response API.post("#{uri}/transactions", attrs.empty? ? nil : Transaction.to_xml(attrs))
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    # Fetches the pdf for this invoice
    def pdf
      self.class.find(to_param, format: 'pdf')
    end

    # Refunds specific line items on the invoice.
    #
    # @return [Invoice, false] Invoice if successful, false if the invoice isn't
    # refundable.
    # @raise [Error] If the refund fails.
    # @param line_items [Array, nil] An array of line items to refund.
    # @param refund_method ["credit_first", "transaction_first"] The method used to refund.
    def refund(line_items = nil, refund_method = 'credit_first')
      return false unless link? :refund
      self.class.from_response(
        follow_link :refund, :body => refund_line_items_to_xml(line_items, refund_method)
      )
    end

    # Refunds the invoice for a specific amount.
    #
    # @return [Invoice, false] Invoice if successful, false if the invoice isn't
    # refundable.
    # @raise [Error] If the refund fails.
    # @param amount_in_cents [Integer, nil] The amount (in cents) to refund.
    # @param refund_method ["credit_first", "transaction_first"] The method used to refund.
    def refund_amount amount_in_cents = nil, refund_method = 'credit_first'
      return false unless link? :refund
      self.class.from_response(
        follow_link :refund, :body => refund_amount_to_xml(amount_in_cents, refund_method)
      )
    end

    def xml_keys
      super - ['currency']
    end

    # Attempts to update the invoice, returning the success of the request.
    # Raises an error if attempting to create an invoice using this method.
    #
    # @return [true, false]
    # @raise [RuntimeError] Raises error if you attempt to create an invoice.
    # @example
    #   invoice = Recurly::Invoice.find('1000')
    #   invoice.po_number = '1234'
    #   invoice.save # => true
    def save
      unless persisted?
        raise "Invoices can only be updated with Invoice#save. New invoices cannot be created using this method."
      end
      super
    end

    private

    def initialize(attributes = {})
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    def refund_amount_to_xml amount_in_cents = nil, refund_method
      builder = XML.new("<invoice/>")
      builder.add_element 'refund_method', refund_method
      builder.add_element 'amount_in_cents', amount_in_cents
      builder.to_s
    end

    def refund_line_items_to_xml line_items = [], refund_method
      builder = XML.new("<invoice/>")
      builder.add_element 'refund_method', refund_method

      node = builder.add_element 'line_items'
      line_items.each do |line_item|
        adj_node = node.add_element 'adjustment'
        adj_node.add_element 'uuid', line_item[:adjustment].uuid
        adj_node.add_element 'quantity', line_item[:quantity]
        adj_node.add_element 'prorate', line_item[:prorate]
      end
      builder.to_s
    end

    # Invoices are only writeable through {Account} instances.
    embedded! true
    undef destroy
  end
end

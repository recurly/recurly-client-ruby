module Recurly
  # Invoices are created through account objects.
  #
  # @example
  #   account = Account.find account_code
  #   account.invoice!
  class Invoice < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Invoice>] A pager that yields +$1+ invoices.
    scope :open,      :state => :open
    scope :collected, :state => :collected
    scope :failed,    :state => :failed
    scope :past_due,  :state => :past_due

    # @return [Account]
    belongs_to :account

    define_attribute_methods %w(
      uuid
      state
      invoice_number
      po_number
      vat_number
      subtotal_in_cents
      tax_in_cents
      total_in_cents
      currency
      created_at
      line_items
      transactions
    )
    alias to_param invoice_number

    # Marks an invoice as paid successfully.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def mark_successful
      return false unless self[:mark_successful]
      reload self[:mark_successful].call
      true
    end

    # Marks an invoice as failing collection.
    #
    # @return [true, false] +true+ when successful, +false+ when unable to
    #   (e.g., the invoice is no longer open).
    def mark_failed
      return false unless self[:mark_failed]
      reload self[:mark_failed].call
      true
    end

    def pdf
      self.class.find to_param, :format => 'pdf'
    end

    private

    def initialize attributes = {}
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    # Invoices are only writeable through {Account} instances.
    embedded! true
    undef save
    undef destroy
  end
end

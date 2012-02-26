module Recurly
  class Transaction < Resource
    require 'recurly/transaction/errors'

    # @macro [attach] scope
    #   @scope class
    #   @return [Pager] a pager that yields +$1+ transactions.
    scope :authorizations, :type  => 'authorization'
    scope :purchases,      :type  => 'purchase'
    scope :refunds,        :type  => 'refund'

    scope :successful,     :state => 'successful'
    scope :failed,         :state => 'failed'
    scope :voided,         :state => 'voided'

    # @return [Account]
    belongs_to :account
		# @return [Invoice, nil]
		belongs_to :invoice

    define_attribute_methods %w(
      uuid
      action
      amount_in_cents
      tax_in_cents
      currency
      status
      reference
      recurring
      test
      voidable
      refundable
      cvv_result
      avs_result
      avs_result_street
      created_at
      details
    )
    alias to_param uuid

    # @return ["credit", "charge", nil] The type of transaction.
    attr_reader :type

    # @see Resource#initialize
    def initialize attributes = {}
      super({ :currency => Recurly.default_currency }.merge attributes)
    end

    # Saves new records only.
    #
    # @return [true, false]
    # @raise [Recurly::Error] For persisted transactions.
    # @see Resource#save
    def save
      return super if new_record?
      raise Recurly::Error, "#{self.class.collection_name} cannot be updated"
    end

    # Refunds the transaction.
    #
    # @return [Transaction, false] The refund when successful, false otherwise.
    # @raise [Error] If the refund fails.
    # @param amount_in_cents [Integer, nil] The amount (in cents) to refund
    #   (refunds fully if nil).
    # @see Transaction#void
    def refund amount_in_cents = nil
      return false unless self[:refund]
      self.class.from_response(
        self[:refund].call :params => { :amount_in_cents => amount_in_cents }
      )
    end

    def signable_attributes
      super.merge :amount_in_cents => amount_in_cents, :currency => currency
    end

    # @return [String]
    def inspect
      attributes = self.class.attribute_names
      unless type == 'credit_card'
        attributes -= %w(cvv_result avs_result avs_result_street)
      end
      super attributes
    end
  end
end

module Recurly
  class CreditPayment < Resource
    # @return [Account, nil]
    belongs_to :account, class_name: :Account, readonly: true

    # @return [Invoice, nil]
    has_one :original_invoice, class_name: :Invoice, readonly: true

    # @return [Invoice, nil]
    has_one :applied_to_invoice, class_name: :Invoice, readonly: true

    define_attribute_methods %w(
      action
      amount_in_cents
      applied_to_invoice_number
      currency
      created_at
      original_credit_payment
      original_credit_payment_uuid
      original_invoice_number
      refund_transaction
      refund_transaction_uuid
      updated_at
      uuid
      voided_at
    )
    alias to_param uuid

    # @return ["charge", "credit", nil] The type of credit payment.
    attr_reader :type

    # https://github.com/recurly/recurly-client-ruby/pull/436
    def marshal_dump
      [
        @attributes.reject { |k, v| v.is_a?(Proc) },
        @new_record,
        @destroyed,
        @uri,
        @href,
        changed_attributes,
        previous_changes,
        response,
        etag,
        links,
        @type
      ]
    end

    def marshal_load(serialization)
      @attributes,
        @new_record,
        @destroyed,
        @uri,
        @href,
        @changed_attributes,
        @previous_changes,
        @response,
        @etag,
        @links,
        @type = serialization
    end
  end
end

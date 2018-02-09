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
      currency
      created_at
      original_credit_payment
      refund_transaction
      updated_at
      uuid
      voided_at
    )
    alias to_param uuid

    # @return ["charge", "credit", nil] The type of credit payment.
    attr_reader :type
  end
end

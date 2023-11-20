module Recurly
  class ExternalInvoice < Resource

    # @return [Plan]
    belongs_to :site
    belongs_to :account
    belongs_to :external_subscription
    belongs_to :external_payment_phase

    # @return [[ExternalCharge], nil]
    has_many :line_items, class_name: :ExternalCharge

    define_attribute_methods %w(
      external_id
      state
      currency
      total
      purchased_at
      created_at
      updated_at
    )

    # We do not expose POST or PUT via the v2 API
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

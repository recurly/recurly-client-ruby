module Recurly
  class ExternalCharge < Resource
    belongs_to :account
    belongs_to :external_invoice
    belongs_to :external_product_reference, optional: true

    define_attribute_methods %w(
      description
      unit_amount
      currency
      quantity
      created_at
      updated_at
    )

    # We do not expose POST or PUT via the v2 API
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

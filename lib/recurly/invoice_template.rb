module Recurly
  class InvoiceTemplate < Resource
    has_many :accounts, class_name: :Account, readonly: true

    define_attribute_methods %w(
      uuid
      name
      code
      description
      created_at
      updated_at
    )
  end
end

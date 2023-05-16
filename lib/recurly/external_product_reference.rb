module Recurly
  class ExternalProductReference < Resource

    # @return [ExternalProduct]
    belongs_to :external_product

    define_attribute_methods %w(
      id
      reference_code
      external_connection_type
      created_at
      updated_at
    )

    # ExternalProductReferences are only writeable and readable through {ExternalProduct} instances.
    embedded! true
  end
end

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

    protected(*%w(save save!))
    private_class_method(*%w(all first paginate scoped where create create!))
  end
end

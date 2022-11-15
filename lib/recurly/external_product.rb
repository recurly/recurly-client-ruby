module Recurly
  class ExternalProduct < Resource

    # @return [Plan]
    belongs_to :plan

    # @return array [ExternalProductReference]
    has_many :external_product_references

    define_attribute_methods %w(
      name
      created_at
      updated_at
    )

    # We do not expose POST or PUT via the v2 API
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

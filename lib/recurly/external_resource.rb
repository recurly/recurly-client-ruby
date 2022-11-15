module Recurly
  class ExternalResource < Resource

    define_attribute_methods %w(
      external_object_reference
    )

    protected(*%w(save save!))
    private_class_method(*%w(all first paginate scoped where create create!))
  end
end

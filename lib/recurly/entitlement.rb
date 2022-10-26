module Recurly
  class Entitlement < Resource
    # @return [Account]
    belongs_to :account

    define_attribute_methods %w(
      account
      customer_permission
      granted_by
      created_at
      updated_at
    )

    # This object does not represent a model on the server side
    # so we do not need to expose these methods.
    protected(*%w(save save!))
    private_class_method(*%w(all find_each first paginate scoped where create! create))
  end
end
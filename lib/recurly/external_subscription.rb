module Recurly
  class ExternalSubscription < Resource

    define_attribute_methods %w(
      quantity
      activated_at
      expires_at
      created_at
      updated_at
      last_purchased
      auto_renew
      app_identifier
    )

    # This object does not represent a model on the server side
    # so we do not need to expose these methods.
    protected(*%w(save save!))
    private_class_method(*%w(all find_each first paginate scoped where create! create))
  end
end
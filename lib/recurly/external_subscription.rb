module Recurly
  class ExternalSubscription < Resource

      # @return [Account]
      belongs_to :account

      # @return [ExternalResource]
      has_one :external_resource
      
      # @return [ExternalProductReference]
      belongs_to :external_product_reference

    define_attribute_methods %w(
      account
      external_resource
      external_product_reference
      quantity
      activated_at
      expires_at
      created_at
      updated_at
      last_purchased
      auto_renew
      app_identifier
    )

    # We do not expose PUT or POST in the v2 API.
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

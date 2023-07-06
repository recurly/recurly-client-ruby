module Recurly
  class ExternalSubscription < Resource

    # @return [Account]
    belongs_to :account

    # @return [ExternalProductReference]
    belongs_to :external_product_reference

    # @return [ExternalInvoice]
    has_many :external_invoices

    define_attribute_methods %w(
      account
      external_id
      external_product_reference
      quantity
      activated_at
      expires_at
      created_at
      updated_at
      last_purchased
      auto_renew
      app_identifier
      state
      trial_started_at
      trial_ends_at
      canceled_at
      in_grace_period
    )

    # We do not expose PUT or POST in the v2 API.
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end

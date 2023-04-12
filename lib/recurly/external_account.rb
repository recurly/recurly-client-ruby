module Recurly
  class ExternalAccount < Resource
    belongs_to :account

    define_attribute_methods %w(
      id
      external_account_code
      external_connection_type
      created_at
      updated_at
    )

    # External Accounts are only writeable and readable through {Account} instances.
    embedded!
    private_class_method :find
  end
end

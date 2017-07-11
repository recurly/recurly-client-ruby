module Recurly
  # The AccountBalance object contains some information about the account's balance.
  # It exists to give us parity with the v1 API which used to include this information with
  # the {Account}. You can get an account's balance by calling {Account#account_balance} on an account instance.
  #
  # Recurly Documentation: https://dev.recurly.com/docs/lookup-account-balance
  class AccountBalance < Resource
    # @return [Account, nil]
    has_one :account, readonly: true

    define_attribute_methods %w(
      past_due
      balance_in_cents
    )

    # This object does not represent a model on the server side
    # so we do not need to expose these methods.
    protected(*%w(save save!))
    private_class_method(*%w(all find_each first paginate scoped where create! create))
  end
end

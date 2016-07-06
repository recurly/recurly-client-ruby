module Recurly
  class AccountBalance < Resource
    # @return [Account, nil]
    has_one :account, :readonly => true

    define_attribute_methods %w(
      past_due
      balance_in_cents
    )
  end
end

module Recurly
  # Recurly Documentation: https://dev.recurly.com/docs/list-account-notes
  class Note < Resource
    # @return [Account]
    belongs_to :account

    define_attribute_methods %w(
      account
      message
      created_at
    )

  end
end
module Recurly
  class Delivery < Resource
    has_one :address

    define_attribute_methods %w(
      deliver_at
      email_address
      first_name
      gifter_name
      last_name
      method
      personal_message
    )
  end
end

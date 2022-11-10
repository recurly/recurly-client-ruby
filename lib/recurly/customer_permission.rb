module Recurly
  class CustomerPermission < Resource
    define_attribute_methods %w(
      id
      code
      name
      description
    )
  end
end
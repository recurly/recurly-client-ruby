module Recurly
  class MeasuredUnit < Resource
    define_attribute_methods %w(
      id
      name
      display_name
      description
      created_at
      updated_at
    )
    alias to_param id
  end
end

module Recurly
  class CustomFieldDefinition < Resource
    define_attribute_methods %w(
      id
      related_type
      name
      user_access
      display_name
      tooltip
      created_at
      updated_at
    )
  end
end

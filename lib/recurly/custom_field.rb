module Recurly
  # Recurly Documentation: https://dev.recurly.com/docs/custom-fields
  class CustomField < Resource

    define_attribute_methods %w(
      name
      value
    )

    # include the name with the serialized field, even though it can't change
    def xml_keys
      attributes.keys
    end
  end
end

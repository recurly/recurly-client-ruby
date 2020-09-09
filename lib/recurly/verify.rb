module Recurly
  class Verify < Resource
    define_attribute_methods %w(
      gateway_code
    )

    def self.to_xml(attrs)
      verify = new attrs
      verify.to_xml
    end
  end
end

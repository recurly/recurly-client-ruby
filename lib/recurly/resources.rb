# Include all resource files
resources = File.join(File.dirname(__FILE__), "resources", "*.rb")
Dir.glob(resources, &method(:require))

module Recurly
  module Resources
    class Empty < Resource
    end

    class Page < Resource
      # leave data untyped
      define_attribute :data, Array, item_type: Hash
      define_attribute :has_more, :Boolean
      define_attribute :next, String
      define_attribute :object, String
    end
  end
end

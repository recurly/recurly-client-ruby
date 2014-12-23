module Recurly
  class Resource
    class Association
      attr_reader :relation, :resource_class

      def initialize relation, resource_class, options = {}
        @relation, @resource_class, @options = relation, resource_class, options
      end

      def class_name
        return @class_name if defined? @class_name
        @class_name = @options[:class_name]
      end
    end
  end
end

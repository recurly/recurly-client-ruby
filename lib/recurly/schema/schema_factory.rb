module Recurly
  class Schema
    # A mixin that allows a class to be treated like a recurly
    # object. This gives the class the power to describe
    # it's schema. It adds the *define_attribute* method
    # and a *schema* reader.
    module SchemaFactory

      # Gets the schema for this class
      # @return [Schema]
      def schema
        @schema ||= ::Recurly::Schema.new
      end

      protected

      # Macro that allows this class to define it's schema and associated
      # attribute getters and setters.
      #
      # @example
      #   class Account
      #     extend Schema::SchemaFactory
      #     define_attribute :code, String, {:read_only=>true}
      #   end
      #   account = Account.new(code: "mycode")
      #   account.schema
      #   #=> Recurly::Schema
      #   acount.code = "newcode" # this method protected since read_only = true
      #   account.code
      #   #=> "mycode"
      def define_attribute(name, type, options = {})
        attribute = schema.add_attribute(name, type, options)

        # Define the reader
        define_method(name) do
          self.attributes[name]
        end

        # Define the writer
        define_method("#{name}=") do |val|
          self.attributes[name] = val
        end

        protected "#{name}=" if attribute.read_only?

        self
      end
    end
  end
end

module Recurly
  class Schema
    # This module is responsible for validating that the raw data
    # passed in to *attributes* matches the schema belonging to this class.
    # It should be mixed in to the Request class.
    module SchemaValidator
      # Validates the attributes and throws an error if something is wrong.
      #
      # @example
      #   Recurly::Requests::PlanCreate.new(code: 'plan123').validate!
      #   #=> {:code=>"plan123"}
      # @example
      #   Recurly::Requests::PlanCreate.new(code: 3.14).validate!
      #   #=> ArgumentError: Attribute 'code' on the resource Recurly::Requests::PlanCreate is type Float but should be a String.
      # @example
      #   Recurly::Requests::PlanCreate.new(kode: 'plan123').validate!
      #   #=> ArgumentError: Attribute 'kode' does not exist on request Recurly::Requests::PlanCreate. Did you mean 'code'?
      #
      # @raise [ArgumentError] if the attribute data does not match the schema.
      def validate!
        attributes.each do |attr_name, val|
          schema_attr = schema.get_attribute(attr_name)
          if schema_attr.nil?
            err_msg = "Attribute '#{attr_name}' does not exist on request #{self.class.name}."
            if did_you_mean = get_did_you_mean(schema, attr_name)
              err_msg << " Did you mean '#{did_you_mean}'?"
              raise ArgumentError, err_msg
            end
          elsif schema_attr.read_only?
            raise ArgumentError, "Attribute '#{attr_name}' on resource #{self.class.name} is not writeable"
          else
            validate_attribute!(schema_attr, val)
          end
        end
      end

      # Validates an individual attribute
      def validate_attribute!(schema_attr, val)
        unless schema_attr.type.is_a?(Symbol) || val.is_a?(schema_attr.type)
          # If it's safely castable, the json deserializer or server
          # will take care of it for us
          unless safely_castable?(val.class, schema_attr.type)
            expected = case schema_attr.type
                       when Array
                         "Array of #{schema_attr.type.item_type}s"
                       else
                         schema_attr.type
                       end

            raise ArgumentError, "Attribute '#{schema_attr.name}' on the resource #{self.class.name} is type #{val.class} but should be a #{expected}"
          end
        end

        # This is the convention for a recurly object
        if schema_attr.type.is_a?(Symbol) && val.is_a?(Hash)
          klazz = Schema.get_recurly_class(schema_attr.type)
          # Using send because the initializer may be private
          instance = klazz.send(:new, val)
          instance.validate!
        end
      end

      # Gets the closest term to the misspelled attribute
      def get_did_you_mean(schema, misspelled_attr)
        closest = schema.attributes.map(&:name).sort_by do |v|
          levenshtein_distance(v, misspelled_attr)
        end.first

        if closest && levenshtein_distance(closest, misspelled_attr) <= 4
          closest
        end
      end

      private

      def safely_castable?(from_type, to_type)
        # TODO we can drop this switch when 2.3 support is dropped
        int_class = if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.4.0")
                      :Integer
                    else
                      :Fixnum
                    end
        int_class = Kernel.const_get(int_class)

        case [from_type, to_type]
        when [Symbol, String]
          true
        when [int_class, Float]
          true
        else
          false
        end
      end

      # This code is copied directly from the did_you mean gem which is based
      # directly on the Text gem implementation.
      #
      # did_you_mean: Copyright (c) 2014-2016 Yuki Nishijima.
      # Text:         Copyright (c) 2006-2013 Paul Battley, Michael Neumann, Tim Fletcher.
      #
      # Returns a value representing the "cost" of transforming str1 into str2
      def levenshtein_distance(str1, str2)
        str1 = str1.to_s unless str1.is_a? String
        str2 = str2.to_s unless str2.is_a? String
        n = str1.length
        m = str2.length
        return m if n.zero?
        return n if m.zero?

        d = (0..m).to_a
        x = nil

        # to avoid duplicating an enumerable object, create it outside of the loop
        str2_codepoints = str2.codepoints

        str1.each_codepoint.with_index(1) do |char1, i|
          j = 0
          while j < m
            cost = (char1 == str2_codepoints[j]) ? 0 : 1
            x = min3(
              d[j + 1] + 1, # insertion
              i + 1,      # deletion
              d[j] + cost # substitution
            )
            d[j] = i
            i = x

            j += 1
          end
          d[m] = x
        end

        x
      end

      def min3(a, b, c)
        if a < b && a < c
          a
        elsif b < c
          b
        else
          c
        end
      end
    end
  end
end

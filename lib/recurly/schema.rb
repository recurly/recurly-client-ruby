module Recurly
  # The class responsible for describing a schema.
  # This is used for requests and resources.
  class Schema
    # The attributes in the schema
    # @return [Hash<String,Attribute>]
    attr_reader :attributes

    def initialize
      @attributes = {}
    end

    # Adds an attribute to the schema definition
    #
    # @param name [Symbol] The name of the attribute
    # @param type [Class,Symbol] The type of the attribute. Use capitalized symbol for Recurly class. Example: :Account.
    # @param options [Schema::Attribute] The created and registered attribute object.
    def add_attribute(name, type, options)
      attribute = Attribute.build(type, options)
      @attributes[name.to_s] = attribute
      attribute
    end

    # Gets an attribute from this schema given a name
    #
    # @param name [String,Symbol] The name/key of the attribute
    # @return [Attribute,nil] The found Attribute. nil if not found.
    def get_attribute(name)
      @attributes[name.to_s]
    end

    # Gets a recurly class given a symbol name.
    #
    # @example
    #   Schema.get_recurly_class(:Account)
    #   #=> Recurly::Resources::Account
    #
    # @param type [Symbol] The name of the class you wish to find
    # @return [Request,Resource]
    # @raise ArgumentError If class can't be found.
    def self.get_recurly_class(type)
      raise ArgumentError, "#{type.inspect} must be a symbol but is a #{type.class}" unless type.is_a?(Symbol)

      if type == :Address
        Recurly::Resources::Address
      elsif Recurly::Requests.const_defined?(type, false)
        Recurly::Requests.const_get(type, false)
      elsif Recurly::Resources.const_defined?(type, false)
        Recurly::Resources.const_get(type, false)
      else
        raise ArgumentError, "Recurly type '#{type}' is unknown"
      end
    end

    class Attribute
      # The type of the attribute. Might be a class like `DateTime`
      # or could be a Recurly object. In this case a symbol should be used.
      # Example: :Account. To get the Recurly type use #recurly_class
      # @return [Class,Symbol]
      attr_reader :type

      PRIMITIVE_TYPES = [
        String,
        Integer,
        Float,
        Hash,
      ].freeze

      def self.build(type, options = {})
        if PRIMITIVE_TYPES.include? type
          PrimitiveAttribute.new(type)
        elsif type == :Boolean
          BooleanAttribute.new
        elsif type == DateTime
          DateTimeAttribute.new
        elsif type.is_a? Symbol
          ResourceAttribute.new(type)
        elsif type == Array
          item_attr = build(options[:item_type])
          ArrayAttribute.new(item_attr)
        else
          throw ArgumentError
        end
      end

      def initialize(type = nil)
        @type = type
      end

      def cast(value)
        value
      end

      def recurly_class
        @recurly_class ||= Schema.get_recurly_class(type)
      end
    end

    class PrimitiveAttribute < Attribute
      def is_valid?(value)
        value.is_a? self.type
      end
    end

    class BooleanAttribute < Attribute
      def is_valid?(value)
        [true, false].include? value
      end
    end

    class DateTimeAttribute < Attribute
      def is_valid?(value)
        value.is_a?(String) || value.is_a?(DateTime)
      end

      def cast(value)
        if value.is_a?(DateTime)
          value
        else
          DateTime.parse(value)
        end
      end

      def type
        DateTime
      end
    end

    class ResourceAttribute < Attribute
      def is_valid?(value)
        value.is_a? Hash
      end

      def cast(value)
        self.recurly_class.cast(value)
      end
    end

    class ArrayAttribute < Attribute
      def is_valid?(value)
        value.is_a? Array
      end

      def cast(value)
        value.map do |v|
          self.type.cast(v)
        end
      end
    end
  end

  require_relative "./schema/schema_factory"
  require_relative "./schema/schema_validator"
  require_relative "./schema/resource_caster"
  require_relative "./schema/request_caster"
end

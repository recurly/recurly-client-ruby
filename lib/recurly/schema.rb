module Recurly
  # The class responsible for describing a schema.
  # This is used for requests and resources.
  class Schema
    # The attributes in the schema
    # @return [Array<Attribute>]
    attr_reader :attributes

    def initialize
      @attributes = []
    end

    # Adds an attribute to the schema definition
    #
    # @param name [Symbol] The name of the attribute
    # @param type [Class,Symbol] The type of the attribute. Use capitalized symbol for Recurly class. Example: :Account.
    # @param options [Hash] The attribute options. See {Attribute#options}
    def add_attribute(name, type, options)
      attribute = Attribute.new(name, type, options)
      @attributes.push(attribute)
      attribute
    end

    # Gets an attribute from this schema given a name
    #
    # @param name [String,Symbol] The name/key of the attribute
    # @return [Attribute,nil] The found Attribute. nil if not found.
    def get_attribute(name)
      name = name.to_s
      @attributes.find { |a| a.name.to_s == name }
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
        Resources::Address
      elsif Requests.const_defined?(type)
        Requests.const_get(type)
      elsif Resources.const_defined?(type)
        Resources.const_get(type)
      else
        raise ArgumentError, "Recurly type '#{type}' is unknown"
      end
    end

    # Describes and attribute for a schema.
    class Attribute
      # The name of the attribute.
      # @return [Symbol]
      attr_accessor :name

      # The type of the attribute. Might be a class like `DateTime`
      # or could be a Recurly object. In this case a symbol should be used.
      # Example: :Account
      # @return [Class,Symbol]
      attr_accessor :type

      # Options for the attribute.
      # @return [Hash]
      attr_accessor :options

      # The description of the attribute for documentation.
      # @return [String]
      attr_accessor :description

      def initialize(name, type, options = {}, description = nil)
        @name = name
        @type = type
        @options = options
        @description = description
      end

      def read_only?
        @options.fetch(:read_only, false)
      end

      def recurly_class
        Schema.get_recurly_class(options[:item_type] || type)
      end

      def is_primitive?
        t = options[:item_type] || type
        t.is_a?(Class) || t == :Boolean
      end
    end

    private_constant :Attribute
  end

  require_relative "./schema/schema_factory"
  require_relative "./schema/schema_validator"
  require_relative "./schema/json_deserializer"
  require_relative "./schema/request_caster"
end

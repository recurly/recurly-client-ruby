require 'active_support/memoizable'

module Recurly

  class Base < ActiveResource::Base
    extend ActiveSupport::Memoizable

    self.format = Recurly::Formats::XmlWithPaginationFormat.new

    def initialize(attributes = {})

      # Add User-Agent to headers
      @default_header ||= {}
      @default_header['User-Agent'] = "Recurly Ruby Client v#{VERSION}"

      super(attributes)
    end

    def update_only
      false
    end

    def valid?
      self.errors.blank?
    end

    # See http://github.com/rails/rails/commit/1488c6cc9e6237ce794e3c4a6201627b9fd4ca09
    # Errors in Rails 2.3.4 are not parsed correctly.
    def save
      if update_only
        update
      else
        save_without_validation
      end
      true
    rescue ActiveResource::ResourceInvalid => error
      case error.response['Content-Type']
      when /application\/xml/
        errors.from_xml(error.response.body)
      when /application\/json/
        errors.from_json(error.response.body)
      end
      false
    end

    # patch persisted? so it looks to see if it actually is persisted
    def persisted?
      @persisted ||= false
      @persisted
    end

    # patch new? to be the opposite of persisted
    def new?
      !persisted?
    end

    # patched to read Errors array
    def load(attributes)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)
      attributes.each do |key, value|
        if key.to_s == 'errors' && value.is_a?(Hash)
          errors.from_array(value.values)
          next
        end
        @attributes[key.to_s] =
          case value
            when Array
              resource = find_or_create_resource_for_collection(key)
              value.map do |attrs|
                if attrs.is_a?(Hash)
                  resource.new(attrs)
                else
                  attrs.duplicable? ? attrs.dup : attrs
                end
              end
            when Hash
              resource = find_or_create_resource_for(key)
              resource.new(value)
            else
              value.dup rescue value
          end
      end
      self
    end

    # builds the object from the transparent results
    def from_transparent_results(response)
      self.load_attributes_from_response(response)
      self
    end

    protected
      # patch load_attributes_from_response so it marks result records as persisted
      def load_attributes_from_response(response)
        super
        @persisted = true
      end

    private
      # patch instantiate_record so it marks result records as persisted
      def self.instantiate_record(record, prefix_options)
        result = super
        result.instance_eval{ @persisted = true }
        result
      end

  end

  # backwards compatibility
  RecurlyBase = Base
end

require 'active_support/memoizable'

module Recurly

  class Base < ActiveResource::Base
    extend ActiveSupport::Memoizable

    self.format = Recurly::Formats::XmlWithErrorsFormat.new

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
        if key.to_s == 'errors' && value.is_a?(Array)
          load_errors_from_array(value)
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
      
      # Patched to read errors with field information
      def load_errors_from_array(new_errors, save_cache = false)
        errors.clear unless save_cache
        return if new_errors.nil? or new_errors.empty?
        humanized_attributes = Hash[self.known_attributes.map { |attr_name| [attr_name.humanize, attr_name] }] unless self.known_attributes.nil?
        humanized_attributes ||= Hash[@attributes.keys.map { |attr_name| [attr_name.humanize, attr_name] }]
        new_errors.each do |error|
          if error.is_a?(Hash)
            field = error['field']
            message = error['message']

            if field.blank?
              errors[:base] << message
            end

            humanized_name = field.humanize
            message = message[(humanized_name.size + 1)..-1] if message[0, humanized_name.size + 1] == "#{humanized_name} "

            errors.add field.to_sym, message
          elsif error.is_a?(String)
            message = error
            attr_message = humanized_attributes.keys.detect do |attr_name|
              if message[0, attr_name.size + 1] == "#{attr_name} "
                errors.add humanized_attributes[attr_name], message[(attr_name.size + 1)..-1]
                next
              end
            end

            errors[:base] << message
          end
        end
      end

    private
      # patch instantiate_record so it marks result records as persisted
      def self.instantiate_record(record, prefix_options)
        result = super
        result.instance_eval{ @persisted = true }
        result
      end

      def build_request_headers(headers, http_method, uri)
        super(headers, http_method, uri).update({'User-Agent' => "Recurly Ruby Client v#{VERSION}"})
      end
  end

  # backwards compatibility
  RecurlyBase = Base
end

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

    # Define #initialize with persisted for our Rails 2.3 and 3.0 friends
    def initialize(attributes = {}, persisted = false)
      @attributes     = {}.with_indifferent_access
      @prefix_options = {}
      @persisted = persisted
      load(attributes)
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
    rescue ActiveResource::ResourceInvalid => e
      load_errors e.response.body
      #raise Recurly::ResourceInvalid.new(e.response, self.errors.full_messages.join(', '))
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
    def load(attributes, remove_root = false)
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
              resource = nil
              value.map do |attrs|
                if attrs.is_a?(Hash)
                  resource ||= find_or_create_resource_for_collection(key)
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
        if (response['Content-Length'].blank? || response['Content-Length'] != "0") && !response.body.nil? && response.body.strip.size > 0
          load(self.class.format.decode(response.body), true)
          @persisted = true
        end
      end

      def load_errors xml
        load_errors_from_array(
          Recurly::Formats::XmlWithErrorsFormat.new.decode(xml)
        )
      rescue => e
        # Fallback to default errors parsing
        errors.from_xml xml
        raise
      end
      
      # Patched to read errors with field information
      def load_errors_from_array(new_errors, save_cache = false)
        errors.clear unless save_cache
        return if new_errors.nil? or new_errors.empty?
        humanized_attributes = Hash[self.class.known_attributes.map { |attr_name| [attr_name.humanize, attr_name] }] unless self.class.known_attributes.nil?
        humanized_attributes ||= Hash[@attributes.keys.map { |attr_name| [attr_name.humanize, attr_name] }]
        new_errors.each do |error|
          if error.is_a?(Hash)
            field = error['field']
            message = error['message']

            if field.blank?
              errors.add :base, message
              next
            end

            humanized_name = field.to_s.humanize.downcase
            message = message[(humanized_name.size + 1)..-1] if message[0, humanized_name.size + 1].downcase == "#{humanized_name} "

            # HACK: Special case nested billing errors
            if self.is_a?(Recurly::BillingInfo) && Recurly::BillingInfo::CreditCard.known_attributes.include?(field) && defined?(self.credit_card) && self.credit_card
              self.credit_card.errors.add field.to_sym, message
              next
            end

            errors.add field.to_sym, message
          elsif error.is_a?(String)
            message = error
            attr_message = humanized_attributes.keys.detect do |attr_name|
              if message[0, attr_name.size + 1] == "#{attr_name} "
                errors.add humanized_attributes[attr_name], message[(attr_name.size + 1)..-1]
                next
              end
            end

            errors.add :base, message
          end
        end
      end

    private
      # Fix @persisted for Rails 2.3, 3.0
      def self.instantiate_record(record, prefix_options = {})
        new(record, true).tap do |resource|
          resource.prefix_options = prefix_options
        end
      end

      def handle_response(response)
        case response.code.to_i
        when 401
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise(UnauthorizedAccess.new(response, message))
        when 403
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise(ForbiddenAccess.new(response, message))
        when 404
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise ResourceNotFound.new(response, message)
        when 422
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise Recurly::ResourceInvalid.new(response, message)
        when 412
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise ClientError.new(response, message)
        when 500
          message = Hash.from_xml(response.body)['errors']['error'] rescue nil
          raise(ServerError.new(response, message))
        else
          super
        end
      end
  end

  # backwards compatibility
  RecurlyBase = Base
end

module ActiveResource
  class Connection
    private
    def default_header
      @default_header ||= {}
      @default_header['User-Agent'] = "Recurly Ruby Client v#{Recurly::VERSION}"
      @default_header
    end
  end
end

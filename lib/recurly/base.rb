require 'active_support/memoizable'

module Recurly
  class RecurlyBase < ActiveResource::Base
    extend ActiveSupport::Memoizable

    self.format = Recurly::Formats::XmlWithPaginationFormat.new

    # Add User-Agent to headers
    def headers
      super
      @headers['User-Agent'] = "Recurly Ruby Client v#{VERSION}"
      @headers
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

    # patch load_attributes_from_response so it marks result records as persisted
    def load_attributes_from_response(response)
      super
      @persisted = true
    end

    # patch instantiate_record so it marks result records as persisted
    def self.instantiate_record(record, prefix_options)
      result = super
      result.instance_eval{ @persisted = true }
      result
    end
  end

  # ActiveRecord treats resources as plural by default.  Some resources are singular.
  class RecurlyAccountBase < RecurlyBase
    self.prefix = "/accounts/:account_code/"

    # Override element_path because this is a singular resource
    def self.element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      prefix_options.merge!(:account_code => id) if id
      # original: "#{prefix(prefix_options)}#{collection_name}/#{URI.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
      "#{prefix(prefix_options)}#{element_name}.#{format.extension}#{query_string(query_options)}"
    end

    # element path
    def element_path(options = nil)
      self.class.element_path(to_param, options || prefix_options)
    end

    def to_param
      attributes[:account_code]
    end

    # Override collection_path because this is a singular resource
    def self.collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      # original: "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}"
      "#{prefix(prefix_options)}#{element_name}.#{format.extension}#{query_string(query_options)}"
    end

  end
end

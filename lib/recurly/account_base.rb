
module Recurly
  # ActiveRecord treats resources as plural by default.  Some resources are singular.
  class AccountBase < Base
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
  
  # backwards compatibility
  RecurlyAccountBase = AccountBase
end
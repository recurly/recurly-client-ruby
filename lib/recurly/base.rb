require "rubygems"
require "active_resource"

# See http://github.com/rails/rails/commit/1488c6cc9e6237ce794e3c4a6201627b9fd4ca09
# Errors in Rails 2.3.4 are not parsed correctly.
module ActiveResource
  class Base
    def update_only
      false
    end
    
    def save
      if update_only
        update
      else
        save_without_validation
      end
      true
    rescue ResourceInvalid => error
      case error.response['Content-Type']
      when /application\/xml/
        errors.from_xml(error.response.body)
      when /application\/json/
        errors.from_json(error.response.body)
      end
      false
    end
  end
end

module Recurly
  
  VERSION = '0.1.3'
  
  class << self
    attr_accessor :username, :password, :site
    
    def configure
      yield self
      
      RecurlyBase.user = username
      RecurlyBase.password = password
      RecurlyBase.site = site || "https://app.recurly.com"
      true
    end
  end
  
  class RecurlyBase < ActiveResource::Base
    
    # Add User-Agent to headers
    def headers
      super
      @headers['User-Agent'] = "Recurly Ruby Client v#{VERSION}"
      @headers
    end
  end
  
  # ActiveRecord treats resources as plural by default.  Some resources are singular.
  class RecurlySingularResourceBase < RecurlyBase
    
    # Override element_path because this is a singular resource
    def self.element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      # original: "#{prefix(prefix_options)}#{collection_name}/#{id}.#{format.extension}#{query_string(query_options)}"
      "#{prefix(prefix_options)}#{CGI::escape(id || '')}/#{element_name}.#{format.extension}#{query_string(query_options)}"
    end
    
    # Override collection_path because this is a singular resource
    def self.collection_path(prefix_options = {}, query_options = nil) 
      prefix_options, query_options = split_options(prefix_options) if query_options.nil? 
      # original: "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}" 
      "#{prefix(prefix_options)}/#{element_name}.#{format.extension}#{query_string(query_options)}"
    end
    
  end
end

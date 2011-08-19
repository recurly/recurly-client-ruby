require 'active_resource/exceptions'
require 'active_resource/validations'

module Recurly
  class RecurlyError < StandardError; end
  
  class ConfigurationError < RecurlyError; end
  
  # Query string has been tampered with and cannot be trusted.
  class ForgedQueryString < RecurlyError; end

  # Transparent Post -- validations failed or transaction failed. See the {model} for errors.
  class ValidationsFailed < RecurlyError
    attr_reader :model

    def initialize(model)
      @model = model
    end

  end

  class ResourceInvalid < ::ActiveResource::ResourceInvalid
    # Overridden to print the actual error message
    def to_s
      message = "Failed."
      message << "  Response code = #{response.code}." if response.respond_to?(:code)
      message << "  Response message = #{@message}." if @message
      message
    end
  end
  
end

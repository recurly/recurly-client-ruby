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
  
end

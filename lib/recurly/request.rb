module Recurly
  # This class represents a request to Recurly.
  # It's used to validate requests data as well as
  # cast and serialize the request data to JSON.
  class Request
    extend Schema::SchemaFactory
    extend Schema::RequestCaster
    include Schema::SchemaValidator

    attr_reader :attributes

    def ==(other_resource)
      self.attributes == other_resource.attributes
    end

    protected

    def initialize(attributes = {})
      @attributes = self.class.cast(attributes.clone)
    end

    def to_s
      self.inspect
    end

    def schema
      self.class.schema
    end
  end
end

module Recurly
  # This class represents an object as it exists on the
  # Recurly servers. It is generated from a response. If you wish to
  # update or change a resource, you need to send a request to the server
  # and get a new Resource.
  class Resource
    extend Schema::SchemaFactory
    extend Schema::JsonDeserializer
    include Schema::SchemaValidator

    attr_reader :attributes

    def requires_client?
      false
    end

    def ==(other_resource)
      self.attributes == other_resource.attributes
    end

    protected

    def initialize(attributes = {})
      @attributes = attributes.clone
    end

    def to_s
      self.inspect
    end

    def schema
      self.class.schema
    end
  end
end

module Recurly
  # This class represents an object as it exists on the
  # Recurly servers. It is generated from a response. If you wish to
  # update or change a resource, you need to send a request to the server
  # and get a new Resource.
  class Resource
    extend Schema::SchemaFactory
    extend Schema::ResourceCaster
    include Schema::SchemaValidator

    attr_reader :attributes

    def requires_client?
      false
    end

    def ==(other_resource)
      other.is_a?(Recurly::Resource) &&
        attributes == other.attributes
    end

    # Hide instance variables to keep from accidental logging
    def inspect
      "#<#{self.class.name}:#{object_id}} @attributes=#{attributes}>"
    end

    def to_s
      self.inspect
    end

    def to_json
      raise NoMethodError, "to_json is not implemented for Resources. Please use Resource#attributes"
    end

    def get_response
      @response
    end

    protected

    def schema
      self.class.schema
    end

    def initialize(attributes = {})
      @attributes = attributes.clone
    end
  end
end

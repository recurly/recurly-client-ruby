require "json"

module Recurly
  # This is a wrapper class to help parse responses into Recurly objects.
  class JSONParser
    # Parses the json body into a recurly object.
    #
    # @param client [Client] The Recurly client which made the request.
    # @param body [String] The JSON string to parse.
    # @return [Resource]
    def self.parse(client, body)
      data = JSON.parse(body)
      from_json(data).tap do |object|
        object.client = client if object.requires_client?
      end
    end

    # Converts the parsed JSON into a Recurly object.
    #
    # @param data [Hash] The parsed JSON data
    # @return [Error,Resource]
    def self.from_json(data)
      type = if data.has_key?("error")
               "error"
             else
               data["object"]
             end
      klazz = self.recurly_class(type)

      unless klazz
        raise ArgumentError, "Unknown resource for json type #{type}"
      end

      data = data["error"] if klazz == Resources::Error

      klazz.from_json(data)
    end

    # Returns the Recurly ruby class responsible for the Recurly json key.
    # TODO figure out how we should handle nil types
    #
    # @example
    #   JSONParser.recurly_class('list')
    #   #=> Recurly::Page
    # @example
    #   JSONParser.recurly_class('shipping_address')
    #   #=> Recurly::Resources::ShippingAddress
    #
    # @param type [String] The JSON key.
    # @return [Resource,Pager,nil]
    def self.recurly_class(type)
      case type
      when nil
        nil
      when "list"
        Resources::Page
      else
        type_camelized = type.split("_").map(&:capitalize).join
        if Resources.const_defined?(type_camelized)
          klazz = Resources.const_get(type_camelized)
          if klazz.ancestors.include?(Resource)
            klazz
          else
            # TODO might want to throw an error?
            nil
          end
        end
      end
    end
  end
end

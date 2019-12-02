require "json"

module Recurly
  # This is a wrapper class to help parse http response into Recurly objects.
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
    # *TODO*: Instead of inferring this type from the `object`
    # attribute. We should instead "register" the response type
    # in the client/operations code. The `get`, `post`, etc methods
    # could explicitly state their response types.
    #
    # @param data [Hash] The parsed JSON data
    # @return [Error,Resource]
    def self.from_json(data)
      type = if data.has_key?("error")
               "error_may_have_transaction"
             else
               data["object"]
             end
      klazz = self.recurly_class(type)

      unless klazz
        raise ArgumentError, "Unknown resource for json type #{type}"
      end

      data = data["error"] if klazz == Resources::ErrorMayHaveTransaction

      klazz.cast(data)
    end

    # Returns the Recurly ruby class responsible for the Recurly json key.
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
        if Resources.const_defined?(type_camelized, false)
          Resources.const_get(type_camelized, false)
        elsif Recurly::STRICT_MODE
          raise ArgumentError, "Could not find Recurly Resource responsible for key #{type}"
        end
      end
    end
  end
end

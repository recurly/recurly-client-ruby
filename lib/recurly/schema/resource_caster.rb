require "date"

module Recurly
  class Schema
    # The purpose of this class is to turn JSON parsed Hashes
    # defined into Recurly ruby objects. It's to be used
    # by the Resource as an extension.
    module ResourceCaster

      # Gives the class the ability to initialize itself
      # given some json data.
      #
      # @example
      #   Recurly::Resources::Account.cast({"code" => "mycode"})
      #   #=> #<Recurly::Resources::Account @attributes={:code=>"mycode"}>
      #
      # @param attributes [Hash] A primitive Hash from JSON.parse of Recurly response.
      # @return [Resource] the {Resource} (ruby object) representing the passed in JSON data.
      def cast(attributes = {})
        resource = new()
        attributes.each do |attr_name, val|
          schema_attr = self.schema.get_attribute(attr_name)

          if schema_attr
            val = if val.nil?
                    val
                  elsif schema_attr.is_valid?(val)
                    schema_attr.cast(val)
                  else
                    if Recurly::STRICT_MODE
                      msg = "#{self.class}##{attr_name} does not have the right type. Value: #{val.inspect} was expected to be a #{schema_attr}"
                      raise ArgumentError, msg
                    end
                  end

            writer = "#{attr_name}="
            resource.send(writer, val)
          elsif Recurly::STRICT_MODE
            raise ArgumentError, "#{resource.class.name} encountered json attribute #{attr_name.inspect}: #{val.inspect} but it's unknown to it's schema"
          end
        end
        resource
      end
    end
  end
end

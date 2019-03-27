require 'date'

module Recurly
  class Schema
    # The purpose of this class is to turn Recurly defined
    # JSON data into Recurly ruby objects. It's to be used
    # by the Resource as an extension.
    module JsonDeserializer
      # Gives the class the ability to initialize itself
      # given some json data.
      #
      # @example
      #   Recurly::Resources::Account.from_json({"code" => "mycode"})
      #   #=> #<Recurly::Resources::Account @attributes={:code=>"mycode"}>
      #
      # @param attributes [Hash] A primitive Hash from JSON.parse of Recurly result.
      # @return [Resource] the {Resource} (ruby object) representing the passed in JSON data.
      def from_json(attributes = {})
        resource = new()
        attributes.each do |attr_name, val|
          next if attr_name == 'object'

          schema_attr = self.schema.get_attribute(attr_name)

          if schema_attr
            # if the Hash val is a recurly type, parse it into a Resource
            val = if val.is_a?(Hash) && !schema_attr.is_primitive?
                    schema_attr.recurly_class.from_json(val)
                  elsif val.is_a?(Array)
                    val.map do |e|
                      if e.is_a?(Hash) && !schema_attr.is_primitive?
                        schema_attr.recurly_class.from_json(e)
                      else
                        e
                      end
                    end
                  elsif val && schema_attr.type == DateTime && val.is_a?(String)
                    DateTime.parse(val)
                  else
                    val
                  end

            writer = "#{attr_name}="

            resource.send(writer, val)
          else
            # TODO ignoring these missing fields for now
            puts "Missing #{attr_name}"
          end
        end
        resource
      end
    end
  end
end

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

          # if the Hash val is a recurly type, parse it into a Resource
          if val.is_a?(Hash) && klazz = JSONParser.recurly_class(val['object'])
            val = klazz.from_json(val)
          elsif val.is_a?(Array)
            val = val.map do |e|
              if e.is_a?(Hash) && klazz = JSONParser.recurly_class(e['object'])
                klazz.from_json(e)
              else
                e
              end
            end
          elsif attr_name.end_with?("_at") && val && val.is_a?(String)
            # TODO should use the schema to determine this probably
            val = DateTime.parse(val)
          end

          writer = "#{attr_name}="

          # TODO maybe check for protected writer first?
          begin
            resource.send(writer, val)
          rescue => e
            # TODO ignoring these missing fields for now
            puts e
          end
        end
        resource
      end
    end
  end
end

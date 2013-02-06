module Recurly
  class Resource
    class Errors < Hash
      def [] key
        super key.to_s
      end

      def []= key, value
        super key.to_s, value
      end

      def full_messages
        map { |attribute, messages|
          attribute_name = attribute.capitalize.gsub('_', ' ')
          messages.map { |message| "#{attribute_name} #{message}." }
        }.flatten
      end
    end
  end
end

require 'rexml/document'

module Recurly
  class XML
    module REXMLAdapter
      def initialize xml
        @root = ::REXML::Document.new(xml).root
      end

      def add_element name, value = nil
        node = root.add_element name
        node.text = value if value
        node
      end

      def each_element xpath = nil
        root.each_element(xpath) { |el| yield el }
      end

      def each element = root
        element.each_element do |el|
          yield el
          each el, &Proc.new
        end
      end

      def name
        root.name
      end

      def [] xpath
        root.get_elements(xpath).first
      end

      def text xpath = nil
        text = root.get_text(xpath) and text.to_s
      end

      def text= text
        root.text = text
      end

      def to_s
        root.to_s
      end
    end

    include REXMLAdapter
  end
end

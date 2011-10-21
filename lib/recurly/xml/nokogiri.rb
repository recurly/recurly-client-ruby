module Recurly
  class XML
    module NokogiriAdapter
      def initialize xml
        @root = Nokogiri(xml).root
      end

      def add_element name, value = nil
        root.add_child(node = ::Nokogiri::XML::Element.new(name, root))
        node << value if value
        node
      end

      def each_element xpath = nil
        elements = xpath.nil? ? root.children : root.xpath(xpath)
        elements.each { |el| yield el }
      end

      def each element = root
        element.elements.each do |el|
          yield el
          each el, &Proc.new
        end
      end

      def name
        root.name
      end

      def [] xpath
        root.at_xpath xpath
      end

      def text xpath = nil
        node = root.at_xpath(xpath) and node.text
      end

      def text= text
        root.content = text
      end

      def to_s
        root.to_xml(:indent => 0).gsub(/$\n/, '')
      end
    end

    include NokogiriAdapter
  end
end

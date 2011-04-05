require 'nokogiri'

module Recurly
  module Formats
    class XmlWithErrorsFormat
      include ActiveResource::Formats::XmlFormat

      def decode(xml)
        doc = Nokogiri::XML(xml)
        data = xml_node_to_hash(doc.root)

        if data.is_a?(Hash) and data["type"] == 'collection' and data["current_page"]
          data = paginate_data(data)
        end

        data
      end

      def xml_node_to_hash(node)
        return node.content.to_s.strip unless node.element?

        node_type = xml_node_type(node)
        if node.children.size == 1 && node.children[0].text?
          return [] if node_type == 'array'
          return xml_node_value(node)
        end

        if node.name == 'errors'
          return node.children.collect do |child|
            error_xml_node_to_hash(child) if child.name == 'error'
          end.reject { |n| n.nil? }
        elsif node_type == 'array'
          return node.children.collect do |child|
            xml_node_to_hash(child)
          end.reject { |n| n.nil? || (n.is_a?(String) && n.blank?) }
        end
        
        return nil if node.children.empty?

        result_hash = {}
        result_hash['type'] = node_type unless node_type.nil?

        node.children.each do |child|
          child_name = child.name
          result = xml_node_to_hash(child)

          next if child_name == 'text' && result == ''

          if result_hash[child_name]
            next if result == ''
            if result_hash[child_name].is_a?(Array)
              result_hash[child_name] << result
            else
              result_hash[child_name] = [result_hash[child_name]] << result
            end
          else
            result_hash[child_name] = result
          end
        end

        result_hash
      end
      
      def error_xml_node_to_hash(node)
        xml_attributes(node).merge('message' => node.children[0].content.to_s)
      end

      def xml_node_value(node)
        return nil if xml_node_nil?(node)

        case xml_node_type(node)
        when 'integer'
          node.content.to_i
        when 'boolean'
          ['true','1'].include?(node.content.downcase)
        when 'datetime'
          Time.parse(node.content)
        else
          node.content.to_s.strip
        end
      end

      def xml_node_nil?(node)
        return true if node.nil?
        attr_node = node.attribute('nil')
        attr_node.nil? ? false : true
      end
      
      def xml_node_type(node)
        attr_node = node.attribute('type')
        attr_node.nil? ? nil : attr_node.value
      end
      
      def xml_attributes(node)
        return {} if node.attribute_nodes.empty?
        values = {}
        node.attribute_nodes.each do |attribute|
          values[attribute.name] = attribute.value
        end
        values
      end

      # convert the data into a paginated resultset (array with singleton methods)
      def paginate_data(data)
        per_page = data["per_page"] || 0
        current_page = data["current_page"] || 0
        total_entries = data["total_entries"] || 0

        # find the first array and use that as the resultset (lame workaround)
        results = data.values.select{|v| v.is_a?(Array)}.first || []
        if results.empty?
          data.delete("per_page")
          data.delete("current_page")
          data.delete("total_entries")
          data.delete("type")
          results = [data.values.first].compact
        end

        # define total_entries accessor on result object
        results.instance_eval "def total_entries; #{total_entries.to_i}; end"

        # define current_page accessor on result object
        results.instance_eval "def current_page; #{current_page.to_i}; end"

        # define per_page accessor on result object
        results.instance_eval "def per_page; #{per_page.to_i}; end"

        results
      end
    end
  end
end

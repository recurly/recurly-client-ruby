module Recurly
  class XML
    ParseError = Class.new(StandardError)

    class << self
      def cast(el)
        # return nil if the `nil` attribute is present
        return if el.attribute 'nil'

        # get the type from the xml attribute but default to nil
        type = if el.attribute('type')
                 el.attribute('type').value
               end

        # try to parse it as a known simple type
        case type
          when 'array'    then el.elements.map { |e| cast(e) }
          when 'boolean'  then el.text == 'true'
          when 'date'     then Date.parse(el.text)
          when 'datetime' then DateTime.parse(el.text)
          when 'float'    then el.text.to_f
          when 'integer'  then el.text.to_i
        else
          # try to find a Resource class responsible for this element
          [el.name, type].each do |name|
            next unless name
            if resource = Recurly::Resource.find_resource_class(name)
              return resource.from_xml(el)
            end
          end

          # fallback to parsing it as a String or a Hash
          if el.elements.empty?
            el.text
          else
            Hash[el.elements.map { |e| [e.name, cast(e)] }]
          end
        end
      end

      def filter(text)
        xml = XML.new text
        xml.each do |el|
          el = XML.new el
          case el.name
          when "number"
            text = el.text.to_s
            last = text[-4, 4]
            el.text = "#{text[0, text.length - 4].to_s.gsub(/\d/, '*')}#{last}"
          when "verification_value"
            el.text = el.text.to_s.gsub(/\d/, '*')
          end
        end
        xml.to_s
      end
    end

    attr_reader :root

    def initialize xml
      @root = xml.is_a?(String) ? super : xml
    end

    # Adds an element to the root.
    def add_element name, value = nil
      value = value.respond_to?(:xmlschema) ? value.xmlschema : value.to_s
      XML.new super(name, value)
    end

    # Iterates over the root's elements.
    def each_element xpath = nil
      return enum_for :each_element unless block_given?
      super
    end

    # Returns the root's name.
    def name
      super
    end

    # Returns an XML string.
    def to_s
      super
    end
  end
end

if defined? Nokogiri
  insecure_noko_msg = <<-MSG

    You are attempting to use an insecure version of
    nokogiri on an insecure version of ruby. Please see
    the documentation on supported versions for more information:
    https://github.com/recurly/recurly-client-ruby#supported-ruby-versions

  MSG
  if RUBY_VERSION < "2.1.0"
    raise insecure_noko_msg
  else
    require 'recurly/xml/nokogiri'
    version = Gem::Version.new(Nokogiri::VERSION)

    if version.segments.length == 3
      major, minor, patch = version.segments
    else
      major, minor, patch, _pre = version.segments
    end

    # Only warning users for now
    if minor < 6
      puts insecure_noko_msg
    elsif minor == 6 && patch < 8
      puts insecure_noko_msg
    elsif minor == 7 && patch < 2
      puts insecure_noko_msg
    elsif minor == 8 && patch < 2
      puts insecure_noko_msg
    end
  end
else
  require 'recurly/xml/rexml'
end

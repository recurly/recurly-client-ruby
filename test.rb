require 'cgi'

# def to_query object, key = nil
#   case object
#   when Hash
#     object.map { |k, v| to_query v, key ? "#{key}[#{k}]" : k }.sort.join '&'
#   when Array
#     object.map { |o| to_query o, "#{key}[]" }.join '&'
#   else
#     "#{CGI.escape key.to_s}=#{CGI.escape object.to_s}"
#   end
# end

# puts CGI.unescape to_query({
#   :a => 1,
#   :b => {
#     1 => 2,
#     3 => 4
#   },
#   :c => [5, 6, 7]
# })


def from_query string
  string.scan(/([^=&]+)=([^=&]*)/).inject({}) do |hash, pair|
    key, value = pair.map &CGI.method(:unescape)
    keypath, array = key.scan(/[^\[\]]+/), key[/\[\]$/]
    keypath.inject(hash) do |nested, component|
      next nested[component] ||= {} unless keypath.last == component
      array ? (nested[component] ||= []) << value : nested[component] = value
    end
    hash
  end
end

p from_query('a=1&b[1]=2&b[3]=&c[]=5&c[]=6&c[]=7')

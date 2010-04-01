require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('recurly', '0.1.4') do |p|
  p.description    = "A Ruby API wrapper for Recurly. Super Simple Subscription billing."
  p.url            = "http://github.com/recurly/recurly-client-ruby"
  p.author         = "Isaac Hall"
  p.email          = "support@recurly.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

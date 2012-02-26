$LOAD_PATH.unshift lib = File.expand_path('../../lib', __FILE__)

require 'stringio'
old_stderr, $stderr = $stderr, StringIO.new
at_exit do
  $stderr.rewind
  $stderr.lines.each { |line| old_stderr.puts line if line.include? lib }
end

require ENV['XML'] if ENV['XML']

require 'recurly'
include Recurly
Recurly.api_key = 'api_key'

require 'logger'
Recurly.logger = Logger.new nil

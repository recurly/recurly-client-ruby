require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + '/../lib/recurly'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

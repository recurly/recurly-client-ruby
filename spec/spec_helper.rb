require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"
require 'recurly'

Recurly.settings_path = "#{File.dirname(__FILE__)}/config/recurly.yml"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# setup recurly authentication details for testing
Recurly.configure_from_yaml
require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + '/../lib/recurly'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require File.dirname(__FILE__) + '/../lib/recurly/rails/config_file.rb'

# loads the settings from yml
Recurly::ConfigFile.reload!

# setup recurly authentication details for testing
Recurly.configure do |c|
  c.username = Recurly::ConfigFile["username"]
  c.password = Recurly::ConfigFile["password"]
  c.site = Recurly::ConfigFile["site"]
end

require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + '/../lib/recurly'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# loads the settings from yml
Recurly::TestSetup.reload!

# setup recurly authentication details for testing
Recurly.configure do |c|
  c.username = Recurly::TestSetup.settings["username"]
  c.password = Recurly::TestSetup.settings["password"]
  c.site = Recurly::TestSetup.settings["site"]
end

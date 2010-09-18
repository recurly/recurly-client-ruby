require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + '/../lib/recurly'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# loads the settings from yml
Recurly::SpecSettings.reload!

# setup recurly authentication details for testing
Recurly.configure do |c|
  c.username = Recurly::SpecSettings["username"]
  c.password = Recurly::SpecSettings["password"]
  c.site = Recurly::SpecSettings["site"]
end

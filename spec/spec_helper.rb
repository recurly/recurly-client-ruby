require 'test/unit'
require 'rubygems'
require "bundler"
Bundler.setup

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"
require 'recurly'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

module SpecHelper
  # add helper methods here
end

RSpec.configure do |config|
  config.include SpecHelper

  config.mock_with :rspec

  config.before(:each) do
    Recurly.settings_path = "#{File.dirname(__FILE__)}/config/recurly.yml"
    Recurly.configure_from_yaml
  end

end


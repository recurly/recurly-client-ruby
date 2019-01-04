require 'bundler/setup'
require 'simplecov'
SimpleCov.start do
  # we will ignore this generated file
  add_filter "lib/recurly/client/operations.rb"
end
require 'recurly'
require_relative './test_schemas'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

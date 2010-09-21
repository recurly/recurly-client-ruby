require 'vcr'
require 'vcr/rspec'
VCR.config do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.http_stubbing_library = :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

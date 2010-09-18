require 'vcr'
VCR.config do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.http_stubbing_library = :webmock
end
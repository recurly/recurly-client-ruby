$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'recurly/version'

Gem::Specification.new do |s|
  s.name             = 'recurly'
  s.version          = Recurly::Version.to_s
  s.summary          = 'Recurly API Client'
  s.description      = 'An API client library for Recurly: https://recurly.com'

  s.files            = Dir['lib/**/*']

  s.extra_rdoc_files = %w(README.md)
  s.rdoc_options     = %w(--main README.md)

  s.author           = 'Recurly'
  s.email            = 'support@recurly.com'
  s.homepage         = 'https://github.com/recurly/recurly-client-ruby'
  s.license          = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  if RUBY_VERSION < "2.2"
    puts "WARNING: The recurly library is only supported on ruby 2.2 and above."
  else
    s.add_development_dependency 'nokogiri', '~> 1.8', '>= 1.8.2'
  end

  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'minitest', '~> 5.8', '>= 5.8.0'
  s.add_development_dependency 'addressable', '~> 2.4', '>= 2.4.0'
  s.add_development_dependency 'webmock', '~> 2.3', '>= 2.3.2'
  s.add_development_dependency 'simplecov', '~> 0'

  if RUBY_PLATFORM != 'java' && !ENV['CI']
    s.add_development_dependency 'yard', '~> 0.9.9'
    s.add_development_dependency 'redcarpet', '~> 3.4', '>= 3.4.0'
    s.add_development_dependency 'racc', '~> 1'
    s.add_development_dependency 'pry', '< 0.11.0', '>= 0.9.10'
    s.add_development_dependency 'pry-nav', '~> 0.2.4'

  end
end

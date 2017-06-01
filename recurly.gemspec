$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'recurly/version'

Gem::Specification.new do |s|
  s.name             = 'recurly'
  s.version          = Recurly::Version.to_s
  s.summary          = 'Recurly API Client'
  s.description      = 'An API client library for Recurly: http://recurly.com'

  s.files            = Dir['lib/**/*']

  s.executables      = %w(recurly)

  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.md)
  s.rdoc_options     = %w(--main README.md)

  s.author           = 'Recurly'
  s.email            = 'support@recurly.com'
  s.homepage         = 'https://github.com/recurly/recurly-client-ruby'
  s.license          = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  if RUBY_VERSION >= "2.1.0"
    s.add_development_dependency('nokogiri','~> 1.7.1')
  end

  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'minitest', '~> 5.8.0'
  s.add_development_dependency 'addressable',  '~> 2.4.0'
  s.add_development_dependency 'webmock',  '~> 2.3.2'

  if RUBY_PLATFORM != 'java' && !ENV['CI']
    s.add_development_dependency 'yard', '~> 0.9.9'
    s.add_development_dependency 'redcarpet'
    s.add_development_dependency 'racc'
    s.add_development_dependency 'pry'
  end
end

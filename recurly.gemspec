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
  s.extra_rdoc_files = %w(README.markdown)
  s.rdoc_options     = %w(--main README.markdown)

  s.author           = 'Recurly'
  s.email            = 'support@recurly.com'
  s.homepage         = 'http://github.com/recurly/recurly-client-ruby'
  s.license          = 'MIT'

  s.add_development_dependency 'rake',           '~> 0.9.2'
  s.add_development_dependency 'minitest',       '~> 2.6.1'
  s.add_development_dependency 'webmock',        '~> 1.7.6'
  s.add_development_dependency 'guard-minitest', '~> 0.4.0'
  s.add_development_dependency 'rb-fsevent',     '~> 0.4.3.1'
  s.add_development_dependency 'growl_notify',   '~> 0.0.1'
end

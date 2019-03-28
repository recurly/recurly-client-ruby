# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'recurly/version'

Gem::Specification.new do |spec|
  spec.name          = "recurly"
  spec.version       = Recurly::VERSION
  spec.authors       = ["Recurly"]
  spec.email         = ["support@recurly.com"]

  spec.summary       = "The ruby client for Recurly's Partner API"
  spec.description   = "The ruby client for Recurly's Partner API"
  spec.homepage      = "https://partner-docs.recurly.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 0.8.11", "<= 1.0.0"

  spec.add_development_dependency "net-http-persistent", "~> 2.9.4"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "simplecov", "~> 0.16"
end

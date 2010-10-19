lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "recurly/version"

Gem::Specification.new do |s|
  s.name        = "recurly"
  s.version     = Recurly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Isaac Hall", "Jacques Crocker"]
  s.email       = ["support@recurly.com"]
  s.homepage    = "http://github.com/recurly/recurly-client-ruby"
  s.summary     = "Ruby API wrapper for Recurly"
  s.description = "A Ruby API wrapper for Recurly. Super Simple Subscription billing."

  s.rubygems_version = ">= 1.3.7"
  s.rubyforge_project = "recurly"

  s.add_dependency("activeresource", [">= 2.3"])
  s.add_dependency("activesupport",  [">= 2.3"])

  s.add_development_dependency("rspec", [">= 2.0.0.beta.22"])
  s.add_development_dependency("webmock")
  s.add_development_dependency("vcr")

  s.files        = Dir.glob("lib/**/*") + %w(init.rb LICENSE README.md)
  s.test_files   = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8"]
end
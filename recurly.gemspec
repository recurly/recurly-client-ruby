# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "recurly/version"

Gem::Specification.new do |spec|
  spec.name = "recurly"
  spec.version = Recurly::VERSION
  spec.authors = ["Recurly"]
  spec.email = ["dx@recurly.com"]

  spec.summary = "The ruby client for Recurly's V3 API"
  spec.description = "The ruby client for Recurly's V3 API"
  spec.homepage = "https://github.com/recurly/recurly-client-ruby"
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://dev.recurly.com/docs",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "#{spec.homepage}/tree/#{spec.version}",
  }

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "rufo", "~> 0.11"
end

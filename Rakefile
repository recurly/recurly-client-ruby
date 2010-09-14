require 'rubygems'
require 'rake'

require "bundler"
Bundler.setup

require 'echoe'

Echoe.new('recurly', '0.1.4') do |p|
  p.description    = "A Ruby API wrapper for Recurly. Super Simple Subscription billing."
  p.url            = "http://github.com/recurly/recurly-client-ruby"
  p.author         = "Isaac Hall"
  p.email          = "support@recurly.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

require 'rspec'
require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

Rspec::Core::RakeTask.new(:rcov) do |spec|
  # spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
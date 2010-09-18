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

namespace :spec do
  desc "Creates a settings.yml file so you can run the Recurly specs"
  task :setup do
    $LOAD_PATH.unshift "./spec"
    require 'highline/import'

    require 'support/settings'

    # create the initial settings.yml file
    require 'fileutils'
    FileUtils.cp(File.dirname(__FILE__) + '/spec/settings.yml.example', File.dirname(__FILE__) + '/spec/settings.yml')

    # load the settings.yml file
    Recurly::TestSetup.reload!

    puts "Creating a personalized spec/settings.yml so you can run the recurly specs\n"

    # ask for the username
    say "\nStep 1) Go to recurly.com and set up a test account...\n\n"

    Recurly::TestSetup.settings["username"] = ask("\nStep 2) Enter your recurly username (email):", String)

    Recurly::TestSetup.settings["password"] = ask("\nStep 3) Enter your recurly password:", String)

    Recurly::TestSetup.settings["site"] = ask("\nStep 4) Enter your recurly site (e.g. https://testrecurly2-test.recurly.com):", String)

    # saves the yml file
    Recurly::TestSetup.save!
    puts "\nYour settings were saved in spec/settings.yml\n"
    puts "You can now run the recurly specs: rake"
  end
end
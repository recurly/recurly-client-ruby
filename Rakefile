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

$LOAD_PATH.unshift "./spec"
require 'highline/import'
require 'fileutils'

namespace :recurly do

  task :load_settings do
    require 'support/settings'

    # load the settings.yml file
    Recurly::TestSetup.reload!
  end

  desc "Clears out spec/vcr folder along with removing test data from your configured recurly site"
  task :clear_test_data => :load_settings do
    say "Clearing out test data from your account at #{Recurly::TestSetup.settings["site"]}"
    return unless agree "\nAre you sure you want to proceed? (y/n)"
    puts "\n"
    require 'restclient'

    username = Recurly::TestSetup.settings["username"]
    password = Recurly::TestSetup.settings["password"]

    # lets try logging into site
    login_response = nil
    begin
      RestClient.post "https://app.recurly.com/login",
        :user_session => {
          :email => username,
          :password => password
        }

      # yes, RestClient api is weird
      raise "Login Failed for #{username} (we should have gotten a redirect)"
    rescue RestClient::Found => e
      # we got a redirect. horray!
      login_response = e.response
    end

    # now lets clear site data
    begin
      RestClient.post( Recurly::TestSetup.settings["site"]+"/site/test_data",
                       {"_method"=>"delete"},
                       :cookies => login_response.cookies)
      raise "Clearing Didn't work for some reason. Is your site setting correct?"
    rescue RestClient::Found => e
      puts "Data Cleared from: #{Recurly::TestSetup.settings["site"]}!"
    end

    # now lets move spec/vcr
    vcr_folder = "#{File.dirname(__FILE__)}/spec/vcr"
    FileUtils.mkdir_p(vcr_folder)
    FileUtils.rm_r vcr_folder

    puts "VCR Requests cleared from: #{vcr_folder}"
    puts "\n\n"
  end

  desc "Creates a settings.yml file so you can run the Recurly specs"
  task :setup do
    # create the initial settings.yml file
    FileUtils.cp(File.dirname(__FILE__) + '/spec/settings.yml.example', File.dirname(__FILE__) + '/spec/settings.yml')

    # load the settings.yml file
    Rake::Task["recurly:load_settings"].invoke

    puts "Creating a personalized spec/settings.yml so you can run the recurly specs\n"

    # ask for the username
    say "\nStep 1) Go to recurly.com and set up a test account...\n\n"

    Recurly::TestSetup.settings["username"] = ask("\nStep 2) Enter your recurly username (email):", String)

    Recurly::TestSetup.settings["password"] = ask("\nStep 3) Enter your recurly password:", String)

    Recurly::TestSetup.settings["site"] = ask("\nStep 4) Enter your recurly base site url (e.g. https://testrecurly2-test.recurly.com):", String)

    # saves the yml file
    Recurly::TestSetup.save!
    puts "\nYour settings were saved in spec/settings.yml\n"
    puts "You can now run the recurly specs: rake"
  end
end
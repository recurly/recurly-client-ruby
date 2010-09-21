require 'rubygems'
require 'rake'

require "bundler"
Bundler.setup

task :build do
  system "gem build recurly.gemspec"
end

task :install => :build do
  system "gem install recurly-#{Recurly::VERSION}.gem"
end

task :release => :build do
  puts "Tagging #{Recurly::VERSION}..."
  system "git tag -a #{Recurly::VERSION} -m 'Tagging #{Recurly::VERSION}'"
  puts "Pushing to Github..."
  system "git push --tags"
  puts "Pushing to rubygems.org..."
  system "gem push recurly-#{Recurly::VERSION}.gem"
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
require 'fileutils'

namespace :recurly do

  task :load_settings do
    require 'support/spec_settings'

    # load the spec_settings.yml file
    Recurly::SpecSettings.reload!
  end

  desc "Clears out spec/vcr folder along with removing test data from your configured recurly site"
  task :clear => :load_settings do
    puts "\n"
    require 'restclient'

    username = Recurly::SpecSettings["username"]
    password = Recurly::SpecSettings["password"]

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
      RestClient.post( Recurly::SpecSettings["site"]+"/site/test_data",
                       {"_method"=>"delete"},
                       :cookies => login_response.cookies)
      raise "Clearing Didn't work for some reason. Is your site setting correct?"
    rescue RestClient::Found => e
      puts "Data Cleared from: #{Recurly::SpecSettings["site"]}!"
    end

    # now lets move spec/vcr
    vcr_folder = "#{File.dirname(__FILE__)}/spec/vcr"
    FileUtils.mkdir_p(vcr_folder)
    FileUtils.rm_r vcr_folder

    puts "VCR Requests cleared from: #{vcr_folder}"
    puts "\n\n"
  end

  desc "Creates a spec_settings.yml file so you can run the Recurly specs"
  task :setup do
    require 'highline/import'
    # create the initial spec_settings.yml file
    FileUtils.cp(File.dirname(__FILE__) + '/spec/spec_settings.yml.example', File.dirname(__FILE__) + '/spec/spec_settings.yml')

    # load the spec_settings.yml file
    Rake::Task["recurly:load_settings"].invoke

    puts "Creating a personalized spec/spec_settings.yml so you can run the recurly specs\n"

    # ask for the username
    say "\nStep 1) Go to recurly.com and set up a test account...\n\n"
    Recurly::SpecSettings["username"] = ask("\nStep 2) Enter your recurly username (email):", String)

    Recurly::SpecSettings["password"] = ask("\nStep 3) Enter your recurly password:", String)

    Recurly::SpecSettings["site"] = ask("\nStep 4) Enter your recurly base site url (e.g. https://testrecurly2-test.recurly.com):", String)

    # saves the yml file
    Recurly::SpecSettings.save!
    puts "\nYour settings were saved in spec/spec_settings.yml\n"
    puts "You can now run the recurly specs: rake"
  end
end
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

$LOAD_PATH.unshift "spec"
require 'fileutils'

# add recurly
$LOAD_PATH.unshift "lib"
require 'recurly'

Recurly.settings_path = "#{File.dirname(__FILE__)}/spec/config/recurly.yml"

load 'recurly/rails3/recurly.rake'

task :environment do

end

namespace :recurly do
  task :clear => :clear_test_data do

    # now lets move spec/vcr
    vcr_folder = "#{File.dirname(__FILE__)}/spec/vcr"
    FileUtils.mkdir_p(vcr_folder)
    FileUtils.rm_r vcr_folder

    puts "VCR Requests cleared from: #{vcr_folder}"
    puts "\n\n"

  end
end
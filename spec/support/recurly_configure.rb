require 'fileutils'
require 'yaml'

# load settings from a yml file
settings = {}
settings_path = File.dirname(__FILE__) + '/settings.yml'
if File.exists?(settings_path)
  settings = YAML.load_file(settings_path)
else
  require 'fileutils'
  # create settings.yml file
  FileUtils.cp(File.dirname(__FILE__) + '/settings.yml.example', settings_path)
  raise "Settings.yml file not found. One has been created, please edit it with your Recurly auth information"
end

# setup recurly authentication details for testing
Recurly.configure do |c|
  c.username = settings["username"]
  c.password = settings["password"]
  c.site = settings["site"]
end

TEST_PLAN_CODE = settings["test_plan_code"]


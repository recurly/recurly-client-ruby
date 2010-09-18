require 'fileutils'
require 'yaml'
require 'active_support/core_ext/class'

module Recurly
  class TestSetup
    SETTINGS_PATH = File.dirname(__FILE__) + '/../settings.yml'

    # keep all the settings global for now
    cattr_accessor :settings
    self.settings = {}

    def self.reload!
      if File.exists?(SETTINGS_PATH)
        settings = YAML.load_file(SETTINGS_PATH)
      else
        raise "Settings.yml file not found. Run rake recurly:setup to create one"
      end
      self.settings = settings
    end

    def self.save!
      File.open(SETTINGS_PATH, 'w' ) do |out|
        YAML.dump(self.settings, out)
      end
    end
  end
end


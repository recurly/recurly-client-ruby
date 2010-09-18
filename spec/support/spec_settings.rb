require 'fileutils'
require 'yaml'

module Recurly
  module SpecSettings
    SETTINGS_PATH = File.dirname(__FILE__) + '/../spec_settings.yml'

    class << self
      # keep all the settings global for now
      attr_accessor :settings

      def [](val)
        self.settings[val]
      end

      def []=(key,val)
        self.settings[key] = val
      end

      def reload!
        if File.exists?(SETTINGS_PATH)
          self.settings = YAML.load_file(SETTINGS_PATH)
        else
          raise "spec/spec_settings.yml file not found. Run rake recurly:setup to create one"
        end
      end

      def save!
        File.open(SETTINGS_PATH, 'w' ) do |out|
          YAML.dump(self.settings, out)
        end
      end
    end
  end
end


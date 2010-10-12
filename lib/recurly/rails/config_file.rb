module Recurly
  module ConfigFile
    class << self

      # overwrite this if you'd like to load it from another spot
      def settings_path
        "config/recurly.yml"
      end

      # keep all the settings global for now
      attr_accessor :settings

      def [](val)
        self.settings[val]
      end

      def []=(key,val)
        self.settings[key] = val
      end

      def reload!
        if File.exists?(settings_path)
          self.settings = YAML.load_file(settings_path) || {}
        else
          self.settings = {}
          puts "\nconfig/recurly.yml file not found. Run rake recurly:setup to create one\n\n"
        end
      end

      def save!
        File.open(settings_path, 'w' ) do |out|
          YAML.dump(self.settings, out)
        end
      end
    end
  end

end
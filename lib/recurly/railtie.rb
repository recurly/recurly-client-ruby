require 'yaml'

module Recurly #:nodoc:
  class Railtie < Rails::Railtie #:nodoc:
    initializer "configure recurly" do
      config_file = Rails.root.join("config", "recurly.yml")
      if config_file.file?
        settings = YAML.load(ERB.new(config_file.read).result)

        # TODO: use settings
      end
    end

  end
end
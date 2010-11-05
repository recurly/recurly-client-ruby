module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails3/recurly.rake'
    end

    config.after_initialize do
      unless Recurly.configured?
        if ENV["RECURLY_CONFIG"]
          ::Recurly.configure_from_json(ENV["RECURLY_CONFIG"])
        else
          # setup recurly authentication details for testing
          ::Recurly.configure_from_yaml
        end
      end
    end

  end
end
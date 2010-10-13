module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails/recurly.rake'
    end

    config.after_initialize do
      # setup recurly authentication details for testing
      ::Recurly.configure_from_yaml unless Recurly.configured?
    end

  end
end
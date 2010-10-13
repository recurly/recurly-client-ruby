module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails/recurly.rake'
    end

    initializer "setup recurly config" do

      # setup recurly authentication details for testing
      ::Recurly.configure_from_yaml

    end

  end
end
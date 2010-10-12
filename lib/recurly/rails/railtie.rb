require 'recurly/rails/config_file'
module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails/recurly.rake'
    end

    initializer "setup recurly config" do

      ::Recurly::ConfigFile.reload!

      # setup recurly authentication details for testing
      ::Recurly.configure do |c|
        c.username = Recurly::ConfigFile["username"]
        c.password = Recurly::ConfigFile["password"]
        c.site = Recurly::ConfigFile["site"]
      end

    end

  end
end
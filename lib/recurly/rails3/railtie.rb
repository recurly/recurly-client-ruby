module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails3/recurly.rake'
    end

    config.after_initialize do
      Recurly.configure unless Recurly.configured?
    end

  end
end
module Recurly
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'recurly/rails3/recurly.rake'
    end

    config.after_initialize do
      Recurly.configure unless Recurly.configured?
    end

    initializer :recurly_set_accept_language do
      ActionController::Base.class_eval do
        prepend_before_filter do
          # used to default the current accept language to the latest request
          Recurly.current_accept_language = request.env["HTTP_ACCEPT_LANGUAGE"]
        end
      end
    end

  end
end
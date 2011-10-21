module Recurly
  class Railtie < Rails::Railtie
    initializer :recurly_set_logger do
      Recurly.logger = Rails.logger
    end

    initializer :recurly_set_accept_language do
      ActionController::Base.prepend_before_filter do
        Recurly::API.accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
      end
    end
  end
end

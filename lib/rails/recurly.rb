module Recurly
  class Railtie < Rails::Railtie
    initializer :recurly_set_logger do
      Recurly.logger = Rails.logger
    end

    initializer :recurly_set_accept_language do
      prepend_method = :prepend_before_filter
      if ActionController::Base.respond_to?(:prepend_before_action)
        prepend_method = :prepend_before_action
      end

      ActionController::Base.send(prepend_method) do
        Recurly::API.accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
      end
    end
  end
end

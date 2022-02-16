# Recurly is a Ruby client for Recurly's REST API.
module Recurly
  require 'recurly/error'
  require 'recurly/helper'
  require 'recurly/api'
  require 'recurly/resource'
  require 'recurly/shipping_address'
  require 'recurly/billing_info'
  require 'recurly/custom_field'
  require 'recurly/account_acquisition'
  require 'recurly/account'
  require 'recurly/account_balance'
  require 'recurly/add_on'
  require 'recurly/address'
  require 'recurly/tax_detail'
  require 'recurly/tax_type'
  require 'recurly/juris_detail'
  require 'recurly/adjustment'
  require 'recurly/coupon'
  require 'recurly/credit_payment'
  require 'recurly/helper'
  require 'recurly/invoice'
  require 'recurly/invoice_collection'
  require 'recurly/item'
  require 'recurly/js'
  require 'recurly/money'
  require 'recurly/measured_unit'
  require 'recurly/note'
  require 'recurly/plan'
  require 'recurly/redemption'
  require 'recurly/shipping_fee'
  require 'recurly/shipping_method'
  require 'recurly/subscription'
  require 'recurly/subscription_add_on'
  require 'recurly/transaction'
  require 'recurly/usage'
  require 'recurly/version'
  require 'recurly/xml'
  require 'recurly/delivery'
  require 'recurly/gift_card'
  require 'recurly/purchase'
  require 'recurly/webhook'
  require 'recurly/verify'
  require 'recurly/tier'
  require 'recurly/dunning_campaign'
  require 'recurly/dunning_cycle'
  require 'recurly/invoice_template'

  @subdomain = nil

  # This exception is raised if Recurly has not been configured.
  class ConfigurationError < Error
  end

  class << self
    # Set a config based on current thread context.
    # Any default set will say in effect unless overwritten in the config_params.
    # Call this method with out any arguments to have it unset the thread context config values.
    # @param config_params - Hash with the following keys: subdomain, api_key, default_currency
    def config(config_params = nil)
      Thread.current[:recurly_config] = config_params
    end

    # @return [String] A subdomain.
    def subdomain
      if Thread.current[:recurly_config] && Thread.current[:recurly_config][:subdomain]
        return Thread.current[:recurly_config][:subdomain]
      end
      @subdomain || 'api'
    end
    attr_writer :subdomain

    # @return [String] An API key.
    # @raise [ConfigurationError] If not configured.
    def api_key
      if Thread.current[:recurly_config] && Thread.current[:recurly_config][:api_key]
        return Thread.current[:recurly_config][:api_key]
      end

      defined? @api_key and @api_key or raise(
        ConfigurationError, "Recurly.api_key not configured"
      )
    end
    attr_writer :api_key

    # @return [String, nil] A default currency.
    def default_currency
      if Thread.current[:recurly_config] &&  Thread.current[:recurly_config][:default_currency]
        return Thread.current[:recurly_config][:default_currency]
      end

      return  @default_currency if defined? @default_currency
      @default_currency = 'USD'
    end
    attr_writer :default_currency

    # @return [JS] The Recurly.js module.
    def js
      JS
    end

    # Assigns a logger to log requests/responses and more.
    # The logger can only be set if the environment variable
    # `RECURLY_INSECURE_DEBUG` equals `true`.
    #
    # @return [Logger, nil]
    # @example
    #   require 'logger'
    #   Recurly.logger = Logger.new STDOUT
    # @example Rails applications automatically log to the Rails log:
    #   Recurly.logger = Rails.logger
    # @example Turn off logging entirely:
    #   Recurly.logger = nil # Or Recurly.logger = Logger.new nil
    attr_accessor :logger

    def logger=(logger)
      if ENV['RECURLY_INSECURE_DEBUG'].to_s.downcase == 'true'
        @logger = logger
        puts <<-MSG
        [WARNING] Recurly logger enabled. The logger has the potential to leak
        PII and should never be used in production environments.
        MSG
      else
        puts <<-MSG
        [WARNING] Recurly logger has been disabled. If you wish to use it,
        only do so in a non-production environment and make sure
        the `RECURLY_INSECURE_DEBUG` environment variable is set to `true`.
        MSG
      end
    end

    # Convenience logging method includes a Logger#progname dynamically.
    # @return [true, nil]
    def log level, message
      logger.send(level, name) { message }
    end

    if RUBY_VERSION <= "1.9.0"
      def const_defined? sym, inherit = false
        raise ArgumentError, "inherit must be false" if inherit
        super sym
      end

      def const_get sym, inherit = false
        raise ArgumentError, "inherit must be false" if inherit
        super sym
      end
    end
  end
end

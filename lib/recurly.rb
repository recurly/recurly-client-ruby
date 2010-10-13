require 'active_resource'
require 'cgi'

require 'recurly/version'
require 'recurly/formats/xml_with_pagination'
require 'recurly/config_parser'
require 'recurly/rails/railtie' if defined?(::Rails::Railtie)

# configuration
module Recurly

  autoload :RecurlyBase,    'recurly/base'
  autoload :Account,        'recurly/account'
  autoload :BillingInfo,    'recurly/billing_info'
  autoload :Charge,         'recurly/charge'
  autoload :Credit,         'recurly/credit'
  autoload :Invoice,        'recurly/invoice'
  autoload :Plan,           'recurly/plan'
  autoload :Subscription,   'recurly/subscription'
  autoload :Transaction,    'recurly/transaction'

  class << self
    attr_accessor :username, :password, :site

    # default Recurly.settings_path to config/recurly.yml
    unless respond_to?(:settings_path)
      def settings_path
        @settings_path || "config/recurly.yml"
      end

      def settings_path=(new_settings_path)
        @settings_path = new_settings_path
      end
    end

    def configured?
      RecurlyBase.user && RecurlyBase.password && RecurlyBase.site
    end

    def configure
      yield self

      RecurlyBase.user = username
      RecurlyBase.password = password
      RecurlyBase.site = site || "https://app.recurly.com"

      true
    end

    def configure_from_yaml(path = nil)
      configure do |c|
        # parse configuration from yml
        recurly_config = ConfigParser.parse(path)

        if recurly_config.present?
          c.username = recurly_config["username"]
          c.password = recurly_config["password"]
          c.site = recurly_config["site"]
        end
      end
    end
  end
end
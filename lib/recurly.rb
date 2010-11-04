require 'active_resource'
require 'active_support/deprecation'
require 'cgi'

require 'recurly/version'
require 'recurly/formats/xml_with_pagination'
require 'recurly/config_parser'
require 'recurly/rails3/railtie' if defined?(::Rails::Railtie)

# load rails2 fixes
if defined?(::Rails::VERSION::MAJOR) and ::Rails::VERSION::MAJOR == 2
  require 'recurly/rails2/compatibility'
end

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

    def configure_from_heroku(config_string)
      configure do |c|

        # pull out the site
        parts = config_string.split("@")
        c.site = parts.last
        config_string = parts[0..-2].join("@")

        # pull out the username and password
        parts = config_string.split(":")
        c.username = parts.first
        c.password = parts[1..-1].join(":")

      end
    end
  end
end
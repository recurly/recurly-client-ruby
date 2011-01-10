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
      if block_given?
        yield self

        RecurlyBase.user = username
        RecurlyBase.password = password
        RecurlyBase.site = site || "https://app.recurly.com"

        return true
      else
        if ENV["RECURLY_CONFIG"]
          Recurly.configure_from_json(ENV["RECURLY_CONFIG"])
        else
          Recurly.configure_from_yaml
        end
      end
    end

    # allows configuration from a yml file that contains the fields:
    # username,password,site
    def configure_from_yaml(path = nil)
      configure do |c|
        # parse configuration from yml
        recurly_config = ConfigParser.parse(path)

        if recurly_config.present?
          if !recurly_config["username"].blank?
            c.username = recurly_config["username"]
            c.password = recurly_config["password"]
            c.site = recurly_config["site"]
          elsif !recurly_config[Rails.env].blank?
            c.username = recurly_config[Rails.env]["username"]
            c.password = recurly_config[Rails.env]["password"]
            c.site = recurly_config[Rails.env]["site"]
          else
            raise "Configuration YAML is not structured correctly."
          end
          
        end
      end
    end

    # allows configuration from a json string that contains the fields:
    # username,password,site
    def configure_from_json(json_string)
      config_data = ActiveSupport::JSON.decode(json_string)
      configure do |c|
        c.username = config_data['username']
        c.password = config_data['password']
        c.site = config_data['site']
      end
    end

    def current_accept_language
      Thread.current[:recurly_accept_language]
    end

    def current_accept_language=(accept_language)
      Thread.current[:recurly_accept_language] = accept_language
    end
  end
end
require 'active_resource'
require 'active_support/deprecation'
require 'cgi'
require 'openssl'
require 'addressable/uri'

# load ActiveResource patches
if defined?(::Rails::VERSION::MAJOR) and ::Rails::VERSION::MAJOR == 3
  require 'patches/rails3/active_resource/connection'
elsif defined?(::Rails::VERSION::MAJOR) and ::Rails::VERSION::MAJOR == 2
  require 'patches/rails2/active_resource/connection'
end

require 'recurly/version'
require 'recurly/exceptions'
require 'recurly/formats/xml_with_pagination'
require 'recurly/formats/xml_with_errors'
require 'recurly/config_parser'
require 'recurly/rails3/railtie' if defined?(::Rails::Railtie)
require 'recurly/base'

# load rails2 fixes
if defined?(::Rails::VERSION::MAJOR) and ::Rails::VERSION::MAJOR == 2
  require 'recurly/rails2/compatibility'
end

# configuration
module Recurly

  autoload :Account,        'recurly/account'
  autoload :AccountBase,    'recurly/account_base'
  autoload :BillingInfo,    'recurly/billing_info'
  autoload :Charge,         'recurly/charge'
  autoload :Coupon,         'recurly/coupon'
  autoload :Credit,         'recurly/credit'
  autoload :Invoice,        'recurly/invoice'
  autoload :Plan,           'recurly/plan'
  autoload :Subscription,   'recurly/subscription'
  autoload :Transaction,    'recurly/transaction'
  autoload :Transparent,    'recurly/transparent'

  class << self
    attr_accessor :username, :password, :environment, :subdomain, :private_key

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
      Base.user && Base.password && Base.site
    end

    def configure
      if block_given?
        yield self

        Base.user = username
        Base.password = password
        Base.site = site_for_environment(environment)

        return true
      else
        if ENV["RECURLY_CONFIG"]
          Recurly.configure_from_json(ENV["RECURLY_CONFIG"])
        else
          Recurly.configure_from_yaml
        end
      end
    end
    
    def site_for_environment(environment)
      environment = :production if environment.nil? # Default to production
      case environment.to_sym
      when :development
        "http://app.lvh.me:3000"
      when :production
        "https://api-production.recurly.com"
      when :sandbox
        "https://api-sandbox.recurly.com"
      else
        raise Recurly::ConfigurationError.new("Invalid environment (#{environment}). Valid values are: :production, :sandbox.")
      end
    end


    # allows configuration from a yml file that contains the fields:
    # username,password,site,private_key
    def configure_from_yaml(path = nil)
      configure do |c|
        # parse configuration from yml
        recurly_config = ConfigParser.parse(path)

        if recurly_config.present?

          # check for environment specific config
          recurly_env = Rails.env if defined?(Rails) and Rails.respond_to?(:env)
          recurly_env ||= ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"
          recurly_config = recurly_config[recurly_env] if recurly_config.has_key?(recurly_env)

          c.username = recurly_config["username"]
          c.password = recurly_config["password"]
          c.subdomain = recurly_config["subdomain"]
          c.private_key = recurly_config["private_key"]
          c.environment = recurly_config["environment"]
        end
      end
    end

    # allows configuration from a json string that contains the fields:
    # username,password,site,private_key
    def configure_from_json(json_string)
      config_data = ActiveSupport::JSON.decode(json_string)
      configure do |c|
        c.username = config_data['username']
        c.password = config_data['password']
        c.subdomain = config_data['subdomain']
        c.private_key = config_data['private_key']
        c.environment = config_data['environment']
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

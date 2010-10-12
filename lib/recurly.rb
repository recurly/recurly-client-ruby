require 'active_resource'
require 'cgi'
require 'recurly/version'
require 'recurly/formats/xml_with_pagination'
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

    def configure
      yield self

      RecurlyBase.user = username
      RecurlyBase.password = password
      RecurlyBase.site = site || "https://app.recurly.com"

      true
    end
  end
end
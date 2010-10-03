require 'rubygems'
require "active_resource"

require 'cgi'

require 'recurly/version'
require 'recurly/formats/xml_with_pagination'

# configuration
module Recurly
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

require 'recurly/base'
require 'recurly/account'
require 'recurly/billing_info'
require 'recurly/charge'
require 'recurly/credit'
require 'recurly/invoice'
require 'recurly/plan'
require 'recurly/subscription'
require 'recurly/transaction'

require 'recurly/railtie' if defined?(Rails)
require "recurly/version"
require "recurly/schema"
require "recurly/request"
require "recurly/resource"
require "recurly/pager"
# Include all request files
resources = File.join(File.dirname(__FILE__), 'recurly', 'requests', '*.rb')
Dir.glob(resources, &method(:require))
# Include all resource files
resources = File.join(File.dirname(__FILE__), 'recurly', 'resources', '*.rb')
Dir.glob(resources, &method(:require))
require "recurly/errors"
require "recurly/client"

module Recurly
end

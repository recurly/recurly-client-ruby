require "recurly/version"
require "recurly/schema"
require "recurly/request"
require "recurly/resource"
require "recurly/pager"
require "recurly/requests"
require "recurly/resources"
require "recurly/http"
require "recurly/http/http_method"
require "recurly/http/response"
require "recurly/errors"
require "recurly/connection_pool"
require "recurly/http/adapter"
require "recurly/http/default_http_adapter"
require "recurly/client"
require "recurly/webhooks"

module Recurly
  STRICT_MODE = ENV["RECURLY_STRICT_MODE"] && ENV["RECURLY_STRICT_MODE"].downcase == "true"
  if STRICT_MODE
    puts "[Recurly] [WARNING] STRICT_MODE enabled. This should only be used for testing purposes."
  end
end

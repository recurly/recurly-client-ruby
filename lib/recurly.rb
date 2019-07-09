require "recurly/version"
require "recurly/currency_array"
require "recurly/schema"
require "recurly/request"
require "recurly/resource"
require "recurly/pager"
require "recurly/requests"
require "recurly/resources"
require "recurly/http"
require "recurly/errors"
require "recurly/client"

module Recurly
  STRICT_MODE = !ENV["RECURLY_STRICT_MODE"].nil?
  if STRICT_MODE
    puts "[Recurly] [WARNING] STRICT_MODE enabled. This should only be used for testing purposes."
  end
end

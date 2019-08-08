# Include all request files
resources = File.join(File.dirname(__FILE__), "requests", "*.rb")
Dir.glob(resources, &method(:require))

module Recurly
  module Requests
  end
end

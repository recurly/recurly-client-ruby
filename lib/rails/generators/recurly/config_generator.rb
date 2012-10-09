module Recurly
  class ConfigGenerator < Rails::Generators::Base
    desc "Creates a configuration file at config/initializers/recurly.rb"

    # Creates a configuration file at <tt>config/initializers/recurly.rb</tt>
    # when running <tt>rails g recurly:config</tt>.
    def create_recurly_file
      create_file 'config/initializers/recurly.rb', <<EOF
Recurly.subdomain        = ENV['RECURLY_SUBDOMAIN']
Recurly.api_key          = ENV['RECURLY_API_KEY']
Recurly.js.private_key   = ENV['RECURLY_JS_PRIVATE_KEY']

# Recurly.default_currency = 'USD'
EOF
    end
  end
end

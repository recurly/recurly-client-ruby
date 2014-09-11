module Recurly
  class ConfigGenerator < Rails::Generators::Base
    desc "Creates a configuration file at config/initializers/recurly.rb"

    # Creates a configuration file at <tt>config/initializers/recurly.rb</tt>
    # when running <tt>rails g recurly:config</tt>.
    def create_recurly_file
      create_file 'config/initializers/recurly.rb', <<EOF

# Required (this should contain subdomain for your recurly account)
Recurly.subdomain = ENV['RECURLY_SUBDOMAIN']

# Required (this is your "Private API Key" which can be found under "API Credentials" in the admin panel
Recurly.api_key = ENV['RECURLY_API_KEY']

# Optional (if you want to change the default currency from USD)
# Recurly.default_currency = 'USD'

EOF
    end
  end
end

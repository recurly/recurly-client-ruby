namespace :recurly do

  # loads settings
  task :load_settings => :environment do
    # load the recurly.yml file
    @recurly_config = Recurly::ConfigParser.parse
  end

  desc "Clears out the Test data from your configured Recurly site (does not touch your production site)"
  task :clear_test_data => :load_settings do
    puts "\n"

    begin
      require 'restclient'
    rescue LoadError
      puts "Install the 'rest-client' gem in order to automatically clear your recurly test data via a rake task. If using Bundler, add it to your project's Gemfile (in :development group) and run again."
      exit
    end

    username = @recurly_config["username"]
    password = @recurly_config["password"]

    # lets try logging into site
    login_response = nil
    begin
      RestClient.post "https://app.recurly.com/login",
        :user_session => {
          :email => username,
          :password => password
        }

      # yes, RestClient api is weird
      raise "Login Failed for #{username} (we should have gotten a redirect)"
    rescue RestClient::Found => e
      # we got a redirect. horray!
      login_response = e.response
    end

    # now lets clear site data
    begin
      RestClient.post( @recurly_config["site"]+"/site/test_data",
                       {"_method"=>"delete"},
                       :cookies => login_response.cookies)
      raise "Clearing Didn't work for some reason. Is your site setting correct?"
    rescue RestClient::Found => e
      puts "Test Data Cleared from: #{@recurly_config["site"]}"
    end
  end

  def setup_static
    @recurly_config["username"] ||= "myemail@mydomain.com"
    @recurly_config["password"] ||= "my_api_key"
    @recurly_config["private_key"] ||= "my_private_key"
    @recurly_config["subdomain"] ||= "mysite"
    @recurly_config["site"] ||= "https://api-production.recurly.com"
  end

  desc "Creates a recurly.yml config file"
  task :setup => :environment do

    # load the recurly.yml file
    Rake::Task["recurly:load_settings"].invoke

    setup_static
    puts "Settings file generated at:\n#{Recurly.settings_path}\n"
    puts "Edit this file to configure your Recurly settings.\n"

    # saves the yml file
    Recurly::ConfigParser.save(@recurly_config)
  end
end

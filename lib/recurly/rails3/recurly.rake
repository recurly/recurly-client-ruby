namespace :recurly do

  # loads settings
  task :load_settings => :environment do
    # load the recurly.yml file
    @recurly_config = Recurly::ConfigParser.parse
  end

  desc "Clears out the Test data from your configured Recurly site (does not touch your data in production mode)"
  task :clear_test_data => :load_settings do
    puts "\n"

    begin
      require 'restclient'
    rescue LoadError
      puts "Install the 'rest-client' gem in order to automatically clear your recurly test data via a rake task. If using Bundler, add it to your project's Gemfile (in :development group) and run again."
      exit
    end

    api_key = @recurly_config["api_key"]
    environment = @recurly_config["environment"]

    # now lets clear site data
    begin
      if environment == :development
        RestClient.delete("http://#{api_key}@api.lvh.me:3000/configuration/test_data")
      else
        RestClient.delete("https://#{api_key}@api.recurly.com/configuration/test_data")
      end
      raise "Clearing Didn't work for some reason. Is your site setting correct?"
    rescue RestClient::Found => e
      puts "Test Data Cleared"
    end
  end

  def setup_static
    @recurly_config["api_key"] ||= "my_api_key"
    @recurly_config["private_key"] ||= "my_private_key"
    @recurly_config["subdomain"] ||= "mysite"
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

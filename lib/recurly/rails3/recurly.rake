namespace :recurly do

  # loads settings
  task :load_settings => :environment do
    # load the recurly.yml file
    @recurly_config = Recurly::ConfigParser.parse
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

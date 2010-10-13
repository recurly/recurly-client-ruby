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

  desc "Creates a recurly.yml config file"
  task :setup => :environment do

    # load the recurly.yml file
    Rake::Task["recurly:load_settings"].invoke

    puts "Creating a recurly.yml config file for your project\n"

    begin
      require 'highline/import'
    rescue LoadError
      puts "Install the 'highline' gem for a more interactive experience. If using Bundler, add it to your project's Gemfile (in :development group) and run again."
      exit
    end

    # ask for the username
    say "\nStep 1) Go to recurly.com and set up a test account...\n"
    @recurly_config["username"] = ask("\nStep 2) Enter your recurly username (email):", String)

    @recurly_config["password"] = ask("\nStep 3) Enter your recurly password:", String){ |q| q.echo = "*" }

    @recurly_config["site"] = ask("\nStep 4) Enter your recurly base site url (e.g. https://testrecurly2-test.recurly.com):", String)

    # saves the yml file
    Recurly::ConfigParser.save(@recurly_config)
    puts "\nYour settings were saved in:\n#{Recurly.settings_path}\n"
  end
end
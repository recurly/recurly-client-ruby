namespace :recurly do

  # loads settings
  task :load_settings do
    require 'recurly/rails/config_file'

    # load the recurly.yml file
    Recurly::ConfigFile.reload!
  end

  desc "Clears out spec/vcr folder along with removing test data from your configured recurly site"
  task :clear_test_data => :load_settings do
    puts "\n"

    begin
      require 'restclient'
    rescue LoadError
      puts "Install the 'rest-client' gem in order to automatically clear your recurly test data via a rake task. If using Bundler, add it to your project's Gemfile (in :development group) and run again."
      exit
    end

    username = Recurly::ConfigFile["username"]
    password = Recurly::ConfigFile["password"]

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
      RestClient.post( Recurly::ConfigFile["site"]+"/site/test_data",
                       {"_method"=>"delete"},
                       :cookies => login_response.cookies)
      raise "Clearing Didn't work for some reason. Is your site setting correct?"
    rescue RestClient::Found => e
      puts "Data Cleared from: #{Recurly::ConfigFile["site"]}!"
    end

    # now lets move spec/vcr
    vcr_folder = "#{File.dirname(__FILE__)}/spec/vcr"
    FileUtils.mkdir_p(vcr_folder)
    FileUtils.rm_r vcr_folder

    puts "VCR Requests cleared from: #{vcr_folder}"
    puts "\n\n"
  end

  desc "Creates a config/recurly.yml file so you can run the Recurly specs"
  task :setup do

    FileUtils.mkdir_p("./config")
    FileUtils.touch("./config/recurly.yml")

    # load the recurly.yml file
    Rake::Task["recurly:load_settings"].invoke

    puts "Creating a personalized config/recurly.yml so you can run the recurly specs\n"

    begin
      require 'highline/import'
    rescue LoadError
      puts "Install the 'highline' gem for a more interactive experience. If using Bundler, add it to your project's Gemfile (in :development group) and run again."
      exit
    end

    # ask for the username
    say "\nStep 1) Go to recurly.com and set up a test account...\n\n"
    Recurly::ConfigFile["username"] = ask("\nStep 2) Enter your recurly username (email):", String)

    Recurly::ConfigFile["password"] = ask("\nStep 3) Enter your recurly password:", String){ |q| q.echo = "*" }

    Recurly::ConfigFile["site"] = ask("\nStep 4) Enter your recurly base site url (e.g. https://testrecurly2-test.recurly.com):", String)

    # saves the yml file
    Recurly::ConfigFile.save!
    puts "\nYour settings were saved in config/recurly.yml\n"
  end
end
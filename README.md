Recurly Ruby Client
===================

The Recurly Ruby Client library is an open source library to interact with Recurly's subscription management from your Ruby on Rails website. The library interacts with Recurly's [REST API](http://support.recurly.com/faqs/api).


Usage
-----

Please see the [documentation](http://support.recurly.com/faqs/api/ruby-client) and
[support forums](http://support.recurly.com/discussions) for more information.


Installation
------------

This library can be installed as a gem or a plugin. Your choice.

**Rails3 Bundle Integration:**

    gem "recurly", :git => "http://github.com/railsjedi/recurly-client-ruby.git"


**Plugin Installation (not recommended):**

    script/plugin install http://github.com/railsjedi/recurly-client-ruby.git


Authentication
--------------

The Recurly Ruby Client requires a username and password to connect.  We recommend creating a user just for your API.  Please see the [Authentication](http://support.recurly.com/faqs/api/authentication) documentation for more information.

Create a file in your Rails app at __/config/initializers/recurly_config.rb__ with contents like:

    Recurly.configure do |c|
      c.username = 'api@yourcompany.com'
      c.password = 'super_secret_password'
    end


Demo Application
----------------

[Recurly Ruby Demo App](http://github.com/recurly/recurly-client-ruby-demo)


Examples
--------

All the functionality is demonstrated by the tests in the __spec__ directory.


Running the Specs
------------------

Recurly gem uses RSpec2 for testing. It also uses VCR / Webmock to handle fast and repeatable full integration tests with the API.

The way this works is when each spec is first run, it will save each HTTP request generated within the spec/vcr folder. Subsequent http requests will be mocked using the data contained in these YML files.

The first thing to do is install bundler if you don't already have it:

    gem install bundler

The next thing is to setup all the spec dependencies

    bundle

When first running the specs, you'll need to setup a recurly test account. Use the provided rake task to walk you through creating spec/settings.yml with all the authentication info.

    rake recurly:setup

Now when you run `rake` it will hit recurly's api to run all the specs. Subsequent calls will no longer hit the API (and be run locally).


Clearing Test Data
------------------

You can delete the spec/vcr folder at any time, and it will regenerate the requests to recurly's apis. However if you do this, you'll also need to clear the test data on your recurly account. Here's how (manually):

* Login to Recurly
* Click "Configuration"" on the top right menu
* Select "Clear Test Data"

This is also automated via a rake task. It will delete the spec/vcr files, and clear the data for you on the server (using your settings.yml authentication info).

    rake recurly:clear_test_data


API Documentation
-----------------

Please see the [Recurly API](http://docs.recurly.com/api/basics) for more information.
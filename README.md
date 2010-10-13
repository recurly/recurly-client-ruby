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

**Rails3 Stable Version:**

    gem 'recurly'

**Bleeding Edge Version:**

    gem 'recurly', :git => "http://github.com/recurly/recurly-client-ruby.git"


Setup (Rails 3)
--------------

The Recurly Ruby Client requires a username and password to connect.  We recommend creating a user just for your API.  Please see the [Authentication](http://support.recurly.com/faqs/api/authentication) documentation for more information.

If using Rails 3, the easiest way to get Recurly set up is to run `rake recurly:setup`. This will create a config/recurly.yml that has your recurly account authentication, and the Recurly rails initializer will pick it up on restart of your web app.


Setup (Rails 2 and other frameworks)
--------------

Alternatively, if not using Rails 3, just make sure to call a Recurly configure block somewhere in your applications initialization.

    Recurly.configure do |c|
      c.username = 'api@yourcompany.com'
      c.password = 'super_secret_password'
      c.site = 'https://my-recurly-site.recurly.com'
    end

In Rails 2.x, this code should be in config/initializers/recurly.rb

In Sinatra, it should be within a `configure` block.


Manual Setup via YAML
--------------

You can also configure Recurly via a YAML file by using:

    Recurly.configure_via_yaml("./config/recurly.yml")


The Recurly Configuration YAML is in the format of:

    username: myrecurlyuser@domain.com
    password: myrecurlypassword
    site: https://myrecurlysite.recurly.com


Clearing test data (Rails3)
----------------

The Recurly Railtie (for rails3) includes a rake task that allows you to easily clear out the test data on your Account. This is useful when automating the testing of the api interation within your own app.

    rake recurly:clear_test_data


Rails Demo Application
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

When first running the specs, you'll need to setup a recurly test account. Use the provided rake task to walk you through creating spec/config/recurly.yml with all the authentication info.

    rake recurly:setup

Now when you run `rake` it will hit recurly's api to run all the specs. Subsequent calls will no longer hit the API (and be run locally).


Something go Wrong?
------------------

You can view the full http interactions with Recurly at spec/vcr. Please attached these to any bug reports so we can replicate.


Clearing Test Data in Specs
----------------------------

You can delete the spec/vcr folder at any time, and it will regenerate the requests to recurly's apis. However if you do this, you'll also need to clear the test data on your recurly account. To do this run:

    rake recurly:clear

This will run `recurly:clear_test_data` (using your spec/config/recurly.yml authentication info) to clear out the test data on the server and then delete the associated spec/vcr files so you can start from scratch.

API Documentation
-----------------

Please see the [Recurly API](http://docs.recurly.com/api/basics) for more information.